import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:topicos_4/db.dart';
import 'login_page.dart';
import 'usuario_repository.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({super.key});

  @override
  State<CadastroUsuario> createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  //Constantes
  Color corPadrao = const Color.fromRGBO(73, 104, 141, 1);
  var espacamento = 20.0;
  var tamFonteTitulo = 20.0;
  var tamFonteBotoes = 45.0;
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _passwordVisible = false;

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

                //Dados
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: constrains.maxHeight / 15,
                        width: constrains.maxWidth * 0.8,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Nome Completo',
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
                          style: TextStyle(
                              color: Colors.black, fontSize: constrains.maxHeight/tamFonteBotoes),
                          onChanged: (String nome) {},
                          controller: _nomeController,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento / 2),
                      ),
                      SizedBox(
                        height: constrains.maxHeight / 15,
                        width: constrains.maxWidth * 0.8,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'CPF',
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
                          onChanged: (String cpf) {},
                          controller: _cpfController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento / 2),
                      ),
                      SizedBox(
                        height: constrains.maxHeight / 15,
                        width: constrains.maxWidth * 0.8,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'E-mail',
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
                          onChanged: (String email) {},
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento / 2),
                      ),
                      SizedBox(
                        height: constrains.maxHeight / 15,
                        width: constrains.maxWidth * 0.8,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Telefone',
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
                          onChanged: (String telefone) {},
                          controller: _telefoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento / 2),
                      ),
                      SizedBox(
                        height: constrains.maxHeight / 15,
                        width: constrains.maxWidth * 0.8,
                        child: TextField(
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
                          controller: _senhaController,
                          onChanged: (String senha) {},
                          obscureText: !_passwordVisible,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(espacamento / 2),
                      ),
                      FilledButton(
                        onPressed: () {
                          registraUsuario(
                              _nomeController.text,
                              _cpfController.text,
                              _emailController.text,
                              _telefoneController.text,
                              _senhaController.text);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                            WidgetStatePropertyAll<Color>(corPadrao),
                        ),
                        child: Text(
                          "Criar uma conta",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: constrains.maxHeight / tamFonteBotoes,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ]),

                //Voltar
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

/*
  registraUsuario(String nome, String cpf, String email, String telefone,
      String senha) async {
    try {
      UserCredential credential =
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _senhaController.text,
      );
      if (!context.mounted) return;
      var db = FirebaseFirestore.instance;
      db.collection("Usuários").add(<String, dynamic>{
        "id": credential.user?.uid,
        "nome": nome,
        "cpf": cpf,
        "email": email,
        "telefone": telefone,
        "saldo" : "0"
      });
      showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              title: const Text('Sucesso'),
              content: const Text('Conta criada com sucesso'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
      );
    } on FirebaseAuthException catch (erro) {
      if (erro.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Este e-mail já está em uso'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (erro.code == 'invalid-email' || _emailController.text == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Escolha um endereço de e-mail válido'),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (erro.code == 'weak-password' || _senhaController.text == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('A senha deve ter no mínimo 6 caracteres'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }*/

  registraUsuario(String nome, String cpf, String email, String telefone, String senha) async {
    if (senha.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A senha deve ter no mínimo 6 caracteres'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
      var usuario = DB(false);
      usuario.createUsuario(nome,senha,email,telefone);

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Sucesso'),
          content: const Text('Conta criada com sucesso'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'OK');
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
