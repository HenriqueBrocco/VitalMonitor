import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'db.dart';
import 'side_menu.dart';
import 'package:provider/provider.dart';
import 'package:topicos_4/bluetooth_provider.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  //Constantes
  Color corPadrao = const Color.fromRGBO(73, 104, 141, 1);
  var espacamento = 20.0;
  var tamFonteTitulo = 40.0;
  var tamFonteBotoes = 50.0;
  bool isSearchBoxVisible = false;
  final searchController = TextEditingController();
  var oxigenacao = '';
  var freqCard = '';
  var pressaoSang = '';
  bool queda = false;

  get items => null;
  String usuarioID = "";
  String nome = "";
  String doc = "";

  bool isAlertDialogShown = false;

  @override
  void initState() {
    super.initState();
    _recuperarDados();
    getNome();
  }

  @override
  Widget build(BuildContext context) {
    var bluetoothProvider = Provider.of<BluetoothProvider>(context);
    _filtraDados(bluetoothProvider.receivedData);
    if (queda && !isAlertDialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showAlertDialog();
      });
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const MenuLateral(),
        appBar: AppBar(
          foregroundColor: corPadrao,
          forceMaterialTransparency: true,
        ),
        body: LayoutBuilder(builder: (context, constrains) {
          espacamento = constrains.maxHeight/55;
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: constrains.maxHeight * 0.14,
                            height: constrains.maxHeight * 0.14,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            /*child: Image.network(
                              "https://picsum.photos/250?image=9",
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),*/
                          ),
                          Padding(
                            padding: EdgeInsets.all(espacamento / 4),
                          ),
                          Text(
                            "Olá $nome!",
                            style: TextStyle(
                                color: corPadrao,
                                fontFamily: 'Monstserrat',
                                fontSize: constrains.maxHeight / tamFonteTitulo,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.all(espacamento),
                          ),
                          Container(
                            width: constrains.maxWidth * 0.9,
                            height: constrains.maxHeight * 0.1,
                            decoration: BoxDecoration(
                              color: corPadrao,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(espacamento / 4),
                                        ),
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: constrains.maxHeight * 0.07,
                                        ),
                                      ]
                                  ),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Frequência cardiáca',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Monstserrat',
                                                    fontSize: constrains.maxHeight / (tamFonteTitulo*1.5)),
                                              ),
                                            ]
                                        ),
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      freqCard.isEmpty ? '?' : freqCard,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Monstserrat',
                                                          fontSize: constrains.maxHeight / (tamFonteTitulo*0.8)),
                                                    ),
                                                    Text(
                                                      ' bpm',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Monstserrat',
                                                          fontSize: constrains.maxHeight / tamFonteTitulo),
                                                    ),
                                                  ]
                                              )
                                            ]
                                        ),
                                      ]
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                          size: constrains.maxHeight * 0.07,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(espacamento / 4),
                                        ),
                                      ]
                                  ),
                                ]
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(espacamento / 2),
                          ),
                          Container(
                            width: constrains.maxWidth * 0.9,
                            height: constrains.maxHeight * 0.1,
                            decoration: BoxDecoration(
                              color: corPadrao,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(espacamento / 4),
                                        ),
                                        Icon(
                                          Icons.opacity,
                                          color: Colors.white,
                                          size: constrains.maxHeight * 0.07,
                                        ),
                                      ]
                                  ),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Oxigenação',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Monstserrat',
                                                    fontSize: constrains.maxHeight / (tamFonteTitulo*1.5)),
                                              ),
                                            ]
                                        ),
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      oxigenacao.isEmpty ? '?' : oxigenacao,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Monstserrat',
                                                          fontSize: constrains.maxHeight / (tamFonteTitulo*0.8)),
                                                    ),
                                                    Text(
                                                      ' %',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Monstserrat',
                                                          fontSize: constrains.maxHeight / tamFonteTitulo),
                                                    ),
                                                  ]
                                              )
                                            ]
                                        ),
                                      ]
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(
                                          Icons.opacity,
                                          color: Colors.white,
                                          size: constrains.maxHeight * 0.07,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(espacamento / 4),
                                        ),
                                      ]
                                  ),
                                ]
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(espacamento / 2),
                          ),
                          Container(
                            width: constrains.maxWidth * 0.9,
                            height: constrains.maxHeight * 0.1,
                            decoration: BoxDecoration(
                              color: corPadrao,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(espacamento / 4),
                                        ),
                                        Icon(
                                          Icons.av_timer,
                                          color: Colors.white,
                                          size: constrains.maxHeight * 0.07,
                                        ),
                                      ]
                                  ),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Pressão sanguínea',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Monstserrat',
                                                    fontSize: constrains.maxHeight / (tamFonteTitulo*1.5)),
                                              ),
                                            ]
                                        ),
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      pressaoSang.isEmpty ? '?' : pressaoSang,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Monstserrat',
                                                          fontSize: constrains.maxHeight / (tamFonteTitulo*0.8)),
                                                    ),
                                                    Text(
                                                      ' mmHg',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Monstserrat',
                                                          fontSize: constrains.maxHeight / tamFonteTitulo),
                                                    ),
                                                  ]
                                              )
                                            ]
                                        ),
                                      ]
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(
                                          Icons.av_timer,
                                          color: Colors.white,
                                          size: constrains.maxHeight * 0.07,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(espacamento / 4),
                                        ),
                                      ]
                                  ),
                                ]
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(espacamento / 2),
                          ),
                          Container(
                            width: constrains.maxWidth * 0.9,
                            height: constrains.maxHeight * 0.1,
                            decoration: BoxDecoration(
                              color: corPadrao,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(espacamento / 4),
                                        ),
                                        Icon(
                                          Icons.sos,
                                          color: Colors.white,
                                          size: constrains.maxHeight * 0.07,
                                        ),
                                      ]
                                  ),
                                  TextButton(
                                    onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Emergência'),
                                        content: const Text('Deseja realizar a ligação para seu contato de emegência cadastrado?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'Cancelar'),
                                            child: const Text('Cancelar'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'Sim'),
                                            child: const Text('Sim'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: Text(
                                      'Emergência',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Monstserrat',
                                          fontSize: constrains.maxHeight / (tamFonteTitulo)),
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(
                                          Icons.sos,
                                          color: Colors.white,
                                          size: constrains.maxHeight * 0.07,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(espacamento / 4),
                                        ),
                                      ]
                                  ),
                                ]
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(espacamento),
                          ),
                          SizedBox(
                            width: constrains.maxHeight * 0.10,
                            height: constrains.maxHeight * 0.10,
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: constrains.maxHeight / 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }

  _recuperarDados() async {
    final usuario = await SharedPreferences.getInstance();
    setState(() {
      usuarioID = usuario.getString("usuarioID") ?? "";
      doc = usuario.getString("doc") ?? "";
    });
  }

  _salvarDados() async {
    final usuario = await SharedPreferences.getInstance();
    await usuario.setString("doc", doc);
  }

  void getNome() async {
    var usuario = DB(false);
    nome = usuario.getUsuarioId(0);

    _salvarDados();
  }

  void _filtraDados(String dado) {
    if(dado.isNotEmpty){
      var dados = dado.split("|");
      oxigenacao = dados[1] == '0'? "" : dados[1];
      freqCard = dados[3] == '0'? "" : dados[3];
      pressaoSang = dados[5] == '0'? "" : dados[5];
      queda = dados[7] == '0'? false : true;
    }
  }

  void _showAlertDialog() {
    setState(() {
      isAlertDialogShown = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false, // Impede que o usuário feche o diálogo clicando fora
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta de Queda'),
          content: const Text('Detectamos uma queda brusca. Deseja contatar o contato de emergência?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isAlertDialogShown = false;
                  queda = false;
                });
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                //Liga
                Navigator.of(context).pop();
                setState(() {
                  isAlertDialogShown = false;
                  queda = false;
                });
              },
              child: const Text('Ligar'),
            ),
          ],
        );
      },
    );
  }
}