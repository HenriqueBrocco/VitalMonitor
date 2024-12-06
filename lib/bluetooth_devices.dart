import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:topicos_4/settings_page.dart';
import 'bluetooth_provider.dart';

class BluetoothScreen extends StatelessWidget {
  //Constantes
  Color corPadrao = const Color.fromRGBO(73, 104, 141, 1);
  var espacamento = 20.0;
  var tamFonteTitulo = 20.0;
  var tamFonteBotoes = 45.0;
  bool notificacoes = false;

  @override
  Widget build(BuildContext context) {
    var bluetoothProvider = Provider.of<BluetoothProvider>(context);

    return Scaffold(body: LayoutBuilder(builder: (context, constrains) {
      espacamento = constrains.maxHeight / 55;
      return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: constrains.maxWidth / 1.05,
            height: constrains.maxHeight / 1.05,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: bluetoothProvider.discoverDevices,
                  child: Text('Buscar Dispositivos'),
                ),

                bluetoothProvider.selectedDevice != null
                    ? Text(
                    'Dispositivo: ${bluetoothProvider.selectedDevice!.name}')
                    : Text('Nenhum dispositivo selecionado'),

                ElevatedButton(
                  onPressed: bluetoothProvider.isConnected
                      ? null
                      : bluetoothProvider.connectToDevice,
                  child: Text(
                      bluetoothProvider.isConnected ? 'Conectado' : 'Conectar'),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Configuracoes()),
                    );
                  },
                  child: Text('Voltar'),
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}