//Inclusão das bibliotecas
#include <Wire.h>
#include "MPU9250.h"
#include "MAX30105.h"
#include "heartRate.h"
#include "BluetoothSerial.h"

//Define erros do BT
#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif
#if !defined(CONFIG_BT_SPP_ENABLED)
#error Serial Port Profile for Bluetooth is not available or not enabled. It is only available for the ESP32 chip.
#endif

//Define o endereço do acelerometro e do Max30102
#define endeAce 0x68 
#define endeMax 0x57

//Criação das classes
MPU9250 senAcele = MPU9250(Wire, endeAce);
MAX30105 senFreqEOxi;
BluetoothSerial SerialBT;

//Status dos sensores
int statusAce;
int statusMax;

//Variaveis de envio BT
int oxigenacao = 0;
int batimento = 0;
float pressao = 0;
bool queda = false;
long intervaloMsgs = 0;
String msg = "";

//Variaveis para calcular frequência cardiaca e oximetria
unsigned long lastBeatTime = 0;  // Armazena o tempo do último batimento
int beatBPM = 0;                 // Variável para armazenar o BPM
long prevIRValue = 0;            // Valor anterior de IR
bool isPeakDetected = false;     // Flag para indicar se um pico foi detectado
int threshold = 10000;           // Defina um limiar para detectar um batimento
bool firstBeat = true;           // Variável para controlar o primeiro batimento
long irValues[10];               // Armazena as últimas 10 leituras de IR
int irIndex = 0;
long dcRed = 0, dcIR = 0;        // Variáveis para armazenar as componentes DC
long acRed = 0, acIR = 0;        // Variáveis para armazenar as componentes AC
long prevRedOxiValue = 0, prevIROxiValue = 0;
long minRed = 0, maxRed = 0;
long minIR = 0, maxIR = 0;
bool firstCycle = true;

// Variáveis para armazenar dados do acelerometro
float prevAccelX = 0;
float prevAccelY = 0;
float prevAccelZ = 0;

void LeAcelerometro()
{
  // Lê o acelerometro
  senAcele.readSensor();

  // Obtém as leituras de aceleração nos eixos X, Y e Z
  float accelX = senAcele.getAccelX_mss();
  float accelY = senAcele.getAccelY_mss();
  float accelZ = senAcele.getAccelZ_mss();
  
  // Calcula a variação de aceleração em cada eixo
  float deltaX = abs(accelX - prevAccelX);
  float deltaY = abs(accelY - prevAccelY);
  float deltaZ = abs(accelZ - prevAccelZ);
  float limiarMovimento = 2.0;  // Ajustável

  // Verifica se a variação em algum dos eixos excede o limiar definido
  if (deltaX > limiarMovimento || deltaY > limiarMovimento || deltaZ > limiarMovimento) {
    queda = true;  // Queda detectada
  }

  // Atualiza os valores anteriores para a próxima leitura
  prevAccelX = accelX;
  prevAccelY = accelY;
  prevAccelZ = accelZ;
}

//Faz a media movel dos ultimos valores medidos pelo sensor infravermelho para melhorar a precisão da medida
long FiltrarMediaMovel(long irValue) {
  irValues[irIndex] = irValue;  // Armazena o valor atual
  irIndex = (irIndex + 1) % 10; // Atualiza o índice circular

  long sum = 0;
  for (int i = 0; i < 10; i++) {
    sum += irValues[i];
  }

  return sum / 10;  // Retorna a média dos últimos 10 valores
}

void LeFrequenciaCardiaca() {
  senFreqEOxi.check();  // Verifica o sensor

  // Obtém o valor atual de IR
  long irValue = senFreqEOxi.getFIFOIR();
  irValue = FiltrarMediaMovel(irValue);

  // Detecta se o valor IR é maior que o limiar e também maior que o valor anterior (subida do pico)
  if (irValue > threshold && irValue > prevIRValue) {
    isPeakDetected = true;  // Pico está subindo
  }

  // Se o valor IR está caindo e já tínhamos detectado uma subida anterior (pico completo)
  if (irValue < prevIRValue && isPeakDetected) {
    // Obtém o tempo atual
    unsigned long currentTime = millis();

    // Se for o primeiro batimento detectado, apenas atualize o tempo e não calcule o BPM
    if (firstBeat) {
      lastBeatTime = currentTime;
      firstBeat = false;  // Após o primeiro batimento, já podemos calcular o BPM nos próximos ciclos
    } else {
      // Calcula o tempo desde o último batimento
      unsigned long timeDifference = currentTime - lastBeatTime;

      // Apenas calcula o BPM se o intervalo de tempo for razoável (para evitar falsos picos)
      if (timeDifference > 500 && timeDifference < 2000) {  // Ignora se o tempo for muito curto ou longo
        beatBPM = 60000 / timeDifference;  // Calcula BPM: 60.000 ms / tempo entre batimentos
        lastBeatTime = currentTime;        // Atualiza o tempo do último batimento      
      }
    }

    // Reseta a flag de detecção de pico
    isPeakDetected = false;
  }

  // Atualiza o valor IR anterior para o próximo ciclo
  prevIRValue = irValue;

  if (millis() - lastBeatTime > 10000) {
    batimento = 0;
    firstBeat = true;
  }
}

void CalculaOxigenacao() {
  senFreqEOxi.check();  // Verifica o sensor

  // Obtém os valores de LED Vermelho e Infravermelho
  long irValue = senFreqEOxi.getFIFOIR();
  long redValue = senFreqEOxi.getFIFORed();
  
  if (irValue > threshold){
    // Inicializa min/max nos primeiros ciclos
    if (firstCycle) {
      minRed = maxRed = redValue;
      minIR = maxIR = irValue;
      firstCycle = false;
    }

    // Atualiza os valores mínimos e máximos
    if (redValue < minRed) minRed = redValue;
    if (redValue > maxRed) maxRed = redValue;

    if (irValue < minIR) minIR = irValue;
    if (irValue > maxIR) maxIR = irValue;

    // Calcula as componentes AC (variação do sinal) e DC (valor médio)
    acRed = maxRed - minRed;
    dcRed = maxRed;

    acIR = maxIR - minIR;
    dcIR = maxIR;

    // Reseta os valores mínimos e máximos para o próximo ciclo
    minRed = maxRed = redValue;
    minIR = maxIR = irValue;

    // Calcula a razão R
    float ratio = (float)(acRed * dcIR) / (acIR * dcRed);
    if(ratio < 1 && ratio > 0.4)
    {
      // Calcula a oxigenação com base na fórmula empírica
      float SpO2 = 110 - 25 * ratio;
      oxigenacao = SpO2;
      // Exibe o resultado
      //Serial.println("Oxigenação (SpO2): " + (String)SpO2 + " / " + (String)ratio);
    }
    
  }
}

void setup(void) 
{
  Wire.begin();
  
  //Inicializa comunicação serial
  Serial.begin(115200);
  delay(1000);
  Serial.println("Inicializando serial");
  while (!Serial) {
    delay(1000);
    Serial.println("Serial não inicializado");
  }
  Serial.println("Serial inicializado");
  
  //Inicializa o acelerometro
  statusAce = senAcele.begin();
  if (statusAce < 0) {
    Serial.println("MAX30102 não foi encontrado. Verifique a ligação/alimentação.");
    Serial.print("Status: ");
    Serial.println(statusAce);
    while (1);
  }

  //Inicializa o sensor de frequência e oximetria
  statusMax = senFreqEOxi.begin(Wire, I2C_SPEED_FAST);
  if (statusMax < 0)
  {
    Serial.println("MAX30102 não foi encontrado. Verifique a ligação/alimentação.");
    Serial.print("Status: ");
    Serial.println(statusMax);
    while (1);
  }

  //Configura o sensor de frequência e oximetria
  byte ledBrightness = 80;                //Opções: 0=Off to 255=50mA - Este valor determina a intensidade da luz emitida pelos LEDs. //70
  byte sampleAverage = 4;                 //Options: 1, 2, 4, 8, 16, 32 - Esse parâmetro define quantas amostras são tomadas e a média delas é utilizada para suavizar os dados. //1
  byte ledMode = 2;                       //Options: 1 = Red only, 2 = Red + IR, 3 = Red + IR + Green 
  int sampleRate = 400;                   //Options: 50, 100, 200, 400, 800, 1000, 1600, 3200 - Isso define quantas amostras por segundo são coletadas pelo sensor. //400
  int pulseWidth = 215;                   //Options: 69, 118, 215, 411 - Isso define a duração do pulso de luz emitido pelos LED // 69
  int adcRange = 16384;                   //Options: 2048, 4096, 8192, 16384 - Para converter o sinal analógico (luz refletida) em dados digitais. //16384
  senFreqEOxi.setup(ledBrightness, sampleAverage, ledMode, sampleRate, pulseWidth, adcRange);

  //Configure o BT
  SerialBT.begin("SmartWatchVM");
}

void loop() 
{
  //Lê sensores
  LeAcelerometro();
  LeFrequenciaCardiaca();
  CalculaOxigenacao();

  if(millis() - intervaloMsgs > 5000){
    batimento = beatBPM;
    String msg = "Oxigenacao|" + (String)oxigenacao + "|Freq|" + (String)batimento + "|Press|" + (String)pressao + "|Queda|" + (String)queda;
    Serial.println(msg);
    intervaloMsgs = millis();
    queda = false;

    //Envia dados
    if(SerialBT.hasClient()){
      SerialBT.print(msg);
    }
  }

  //Estimativa simples e experimental de variação da pressão
  pressao = acIR * batimento / 100;
}
