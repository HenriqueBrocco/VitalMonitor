import 'package:flutter/material.dart';
import 'package:topicos_4/login_page.dart';

class EsqueceuSenha extends StatefulWidget {
  const EsqueceuSenha({super.key});

  @override
  _EsqueceuSenhaState createState() => _EsqueceuSenhaState();
}

class _EsqueceuSenhaState extends State<EsqueceuSenha> {
  //Constantes
  Color corPadrao = const Color.fromRGBO(73, 104, 141, 1);
  var espacamento = 20.0;
  var tamFonteTitulo = 20.0;
  var tamFonteBotoes = 45.0;
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;
  bool _isSendingEmail = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Informe o seu e-mail para receber as instruções de redefinição de senha:',
                        style: TextStyle(
                            color: corPadrao,
                            fontSize: constrains.maxHeight / tamFonteBotoes,
                            fontWeight: FontWeight.w900),
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento / 2),
                      ),
                      SizedBox(
                        height: constrains.maxHeight / 15,
                        width: constrains.maxWidth * 0.95,
                        child: TextField(
                          controller: _emailController,
                          cursorColor: corPadrao,
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            focusColor: corPadrao,
                            labelStyle: TextStyle(
                                color: corPadrao, fontWeight: FontWeight.w600, fontSize: constrains.maxHeight/tamFonteBotoes),
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
                          style: TextStyle(
                              color: Colors.black, fontSize: constrains.maxHeight/tamFonteBotoes),
                          onChanged: (valor) {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento / 2),
                      ),
                      FilledButton(
                        onPressed: _isSendingEmail ? null : _sendResetEmail,
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(corPadrao),
                        ),
                        child: _isSendingEmail
                            ? const CircularProgressIndicator()
                            : Text(
                                "Redefinir",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      constrains.maxHeight / tamFonteBotoes,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                      ),
                    ]),

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
                                  builder: (context) => const Login(),
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
                    ]),
              ],
            ),
          ),
        ),
      );
    }));
  }

  void _sendResetEmail() async {
    String email = _emailController.text.trim();
    bool isValid = _validateEmail(email);

    setState(() {
      _isEmailValid = isValid;
    });

    if (isValid) {
      setState(() {
        _isSendingEmail = true;
      });

      try {
        //await FirebaseAuth.instance.sendPasswordResetEmail(email: email); Sem conexão com banco de dados
        _showSuccessDialog();
      } catch (e) {
        _showErrorDialog();
      } finally {
        setState(() {
          _isSendingEmail = false;
        });
      }
    }
  }

  bool _validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('E-mail enviado'),
          content: Text(
            'Um e-mail com as instruções para redefinir sua senha foi enviado para ${_emailController.text}.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro ao enviar e-mail'),
          content: const Text(
              'Ocorreu um erro ao enviar o e-mail de redefinição de senha. Por favor, tente novamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
