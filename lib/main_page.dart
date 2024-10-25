import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topicos_4/usuario_repository.dart';
import 'db.dart';
import 'side_menu.dart';

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
  //var recovered_data = {};

  get items => null;
  String usuarioID = "";
  String nome = "";
  String doc = "";

  @override
  Widget build(BuildContext context) {
    _recuperarDados();
    getNome();

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
                                                      '75',
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
                                                      '98',
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
                                                      '12/8',
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
                                    onPressed: () {
                                    },
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
}
