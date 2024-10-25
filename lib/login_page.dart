import 'package:flutter/material.dart';
import 'main_page.dart';
import 'password_recover_page.dart';
import 'register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Constantes
  Color corPadrao = const Color.fromRGBO(73, 104, 141, 1);
  var espacamento = 20.0;
  var tamFonteTitulo = 20.0;
  var tamFonteBotoes = 45.0;
  var _lembrar = false;
  var _manterLogin = false;
  bool _passwordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usuarioIDController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _recuperarDados();
  }

  @override
  Widget build(BuildContext context) {
    if (_usuarioIDController.text != "" && _manterLogin) {
      return const Principal();
    }

    return Scaffold(body: LayoutBuilder(builder: (context, constrains) {
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
                        padding: EdgeInsets.all(espacamento/4),
                      ),
                      Text(
                        "VitalMonitor",
                        style: TextStyle(
                            color: corPadrao,
                            fontFamily: 'Monstserrat',
                            fontSize: constrains.maxHeight/tamFonteTitulo,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),

                //Campos de login e esqueceu a senha
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: constrains.maxHeight/15,
                        width: constrains.maxWidth * 0.95,
                        child: TextField(
                          decoration: InputDecoration(
                          labelText: 'E-mail',
                          focusColor: corPadrao,
                          labelStyle: TextStyle(
                              color: corPadrao,
                              fontWeight: FontWeight.w600,
                              fontSize: constrains.maxHeight/tamFonteBotoes),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.indigo,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: corPadrao,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: constrains.maxHeight/tamFonteBotoes),
                        onChanged: (valor) {},
                        controller: _emailController,
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento / 2),
                      ),
                      SizedBox(
                          height: constrains.maxHeight/15,
                          width: constrains.maxWidth * 0.95,
                          child: TextField(
                        cursorColor: corPadrao,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(
                              color: corPadrao,
                              fontWeight: FontWeight.w600,
                              fontSize: constrains.maxHeight/tamFonteBotoes),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.indigo,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: corPadrao,
                            ),
                          ),
                          suffixIcon: IconButton(
                            color: corPadrao,
                            iconSize: constrains.maxHeight * 0.03,
                            icon: _passwordVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: constrains.maxHeight/tamFonteBotoes),
                        onChanged: (String senha) {},
                        controller: _passwordController,
                      ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento / 4),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Checkbox(
                                visualDensity:
                                const VisualDensity(horizontal: -4, vertical: -4),
                                checkColor: Colors.green,
                                fillColor: const WidgetStatePropertyAll<Color>(
                                  Colors.white24,
                                ),
                                value: _lembrar,
                                onChanged: (bool? check) {
                                  setState(() {
                                    _lembrar = check!;
                                  });
                                },
                              ),
                              SizedBox(
                                width: espacamento/2,
                              ),
                              Text(
                                "Lembrar de mim",
                                style: TextStyle(
                                  color: corPadrao,
                                  fontSize: constrains.maxHeight/tamFonteBotoes,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                style: ButtonStyle(
                                  minimumSize: WidgetStateProperty.all<Size>(
                                    const Size(0, 0),
                                  ),
                                ),
                                child: Text(
                                  "Esqueceu a senha?",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: corPadrao,
                                      fontSize: constrains.maxHeight/tamFonteBotoes,
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => const EsqueceuSenha()));
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento/2),
                      ),
                      FilledButton(
                        onPressed: () {
                          login();
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(corPadrao),
                        ),
                        child: Text(
                          "Entrar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: constrains.maxHeight/tamFonteBotoes,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ]
                ),

                //Campos do registrar-se
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Não possui uma conta?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: corPadrao,
                              fontSize: constrains.maxHeight/tamFonteBotoes,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(espacamento/2),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const CadastroUsuario(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              WidgetStatePropertyAll<Color>(corPadrao),
                            ),
                            child: Text(
                              "Registre-se",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: constrains.maxHeight/tamFonteBotoes,
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

  login() async {
    _salvarDados(_lembrar);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Principal()),
    );
  }

  _salvarDados(bool login) async {
    final usuario = await SharedPreferences.getInstance();
    await usuario.setString("usuarioID", _usuarioIDController.text);
    await usuario.setBool("manterLogin", login);
  }

  _recuperarDados() async {
    final usuario = await SharedPreferences.getInstance();
    setState(() {
      _usuarioIDController.text = usuario.getString("usuarioID") ?? "";
      _manterLogin = usuario.getBool("manterLogin") ?? false;
    });
  }
}
