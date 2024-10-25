import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  static const double espacamento = 5;
  bool notificacoes = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Configurações',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/tela_login.png'),
              fit: BoxFit.fill,
            )),
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(espacamento),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Notificações: ',
                      style: TextStyle(color: Colors.black, fontSize: 20),
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
                const Padding(
                  padding: EdgeInsets.all(espacamento),
                ),
                TextButton(
                  onPressed: () {
                    _removerDados();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: const Text(
                    "Sair",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(espacamento),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF419B5B),
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).primaryColor),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      AlertDialog(
                        title: const Text('Sinto muito'),
                        content: const Text(
                            'Essa tela ainda não foi habilitada para uso, devido ao fato de ser início do projeto'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                    icon: const Icon(OctIcons.graph_16),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.home),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Configuracoes()));
                    },
                    icon: const Icon(Icons.settings),
                  ),
                  IconButton(
                    onPressed: () {
                      AlertDialog(
                        title: const Text('Sinto muito'),
                        content: const Text(
                            'Essa tela ainda não foi habilitada para uso, devido ao fato de ser início do projeto'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                    icon: const Icon(Icons.camera),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Tela...()));*/
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  _removerDados() async{
    final usuario = await SharedPreferences.getInstance();
    usuario.remove("usuarioID");
  }
}