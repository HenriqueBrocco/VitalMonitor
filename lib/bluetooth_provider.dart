import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothProvider extends ChangeNotifier {
  BluetoothDevice? _selectedDevice;
  BluetoothConnection? _connection;
  bool _isConnected = false;
  String _receivedData = '';

  String get receivedData => _receivedData;
  bool get isConnected => _isConnected;
  BluetoothDevice? get selectedDevice => _selectedDevice;

  // Busca dispositivos pareados
  Future<void> discoverDevices() async {
    List<BluetoothDevice> devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    if (devices.isNotEmpty) {
      _selectedDevice = devices[0];
      notifyListeners();
    }
  }

  // Conecta ao dispositivo selecionado
  Future<void> connectToDevice() async {
    if (_selectedDevice != null) {
      BluetoothConnection.toAddress(_selectedDevice!.address).then((conn) {
        _connection = conn;
        _isConnected = true;
        notifyListeners();

        // Recebe os dados e atualiza o estado
        _connection!.input!.listen((data) {
          _receivedData = String.fromCharCodes(data);
          notifyListeners();  // Notifica os listeners sobre a mudança dos dados
        }).onDone(() {
          _isConnected = false;
          notifyListeners();
        });
      }).catchError((error) {
        print('Erro de conexão: $error');
      });
    }
  }

  void disposeConnection() {
    _connection?.dispose();
    _isConnected = false;
    notifyListeners();
  }
}