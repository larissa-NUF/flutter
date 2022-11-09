import 'package:calculadora/ListarUsuarios.dart';
import 'package:flutter/material.dart';

import 'Login.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text('Usuários'),
            onTap: () => {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListarUsuarios()),
            )},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () => {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyCustomForm()),
            )
            },
          ),
        ],
      ),
    ),
    );
  }
}
