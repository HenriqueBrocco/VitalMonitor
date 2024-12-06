import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'bluetooth_devices.dart';
import 'login_page.dart';
import 'main_page.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  //Constantes
  Color corPadrao = const Color.fromRGBO(73, 104, 141, 1);
  var espacamento = 20.0;
  var tamFonteTitulo = 20.0;
  var tamFonteBotoes = 45.0;
  bool notificacoes = false;

  @override
  Widget build(BuildContext context) {
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
                //Logo e texto
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: constrains.maxHeight * 0.2,
                        height: constrains.maxHeight * 0.2,
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento / 4),
                      ),
                      Text(
                        "VitalMonitor",
                        style: TextStyle(
                            color: corPadrao,
                            fontFamily: 'Monstserrat',
                            fontSize: constrains.maxHeight / tamFonteTitulo,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),

                //Campos
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Notificações: ',
                      style: TextStyle(
                        color: corPadrao,
                        fontSize: constrains.maxHeight / tamFonteBotoes,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Switch(
                      value: notificacoes,
                      //thumbColor:
                      //MaterialStatePropertyAll<Color>(Theme.of(context).primaryColor),
                      onChanged: (bool value) {
                        // This is called when the user toggles the switch.
                        setState(() {
                          notificacoes = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          //scanDispositivosBT();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {return BluetoothScreen();},
                            ),
                          );
                        },
                        child: Text(
                          "Conectar dispositivo BT",
                          style: TextStyle(
                            color: corPadrao,
                            fontSize: constrains.maxHeight / tamFonteBotoes,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ]
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: Text(
                          "Sair",
                          style: TextStyle(
                            color: corPadrao,
                            fontSize: constrains.maxHeight / tamFonteBotoes,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ]
                ),

                //Botão voltar
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Principal(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll<Color>(corPadrao),
                            ),
                            child: Text(
                              "Voltar",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: constrains.maxHeight / tamFonteBotoes,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
/*
  _removerDados() async {
    final usuario = await SharedPreferences.getInstance();
    usuario.remove("usuarioID");
  }*/
}
