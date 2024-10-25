import 'package:flutter/material.dart';
import 'package:topicos_4/main_page.dart';
import 'package:topicos_4/settings_page.dart';

import 'login_page.dart';

class MenuLateral extends StatefulWidget {
  const MenuLateral({super.key});

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  //Constantes
  Color corPadrao = const Color.fromRGBO(73, 104, 141, 1);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: corPadrao,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage('assets/images/logo.png'))),
            child: null,
          ),
          ListTile(
            leading: const Icon(
              Icons.input,
              color: Colors.white,
            ),
            title: const Text(
              'Tela principal',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Principal(),
                ),
              )
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.verified_user,
              color: Colors.white,
            ),
            title: const Text(
              'Perfil',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: const Text(
              'Configurações',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () => {Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Configuracoes(),
              ),
            )},
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            title: const Text(
              'Deslogar',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              )
            },
          ),
        ],
      ),
    );
  }
}
