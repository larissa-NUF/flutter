import 'dart:convert';

import 'package:calculadora/Cadastrar.dart';
import 'package:calculadora/model/Usuario.dart';

import 'Layout.dart';
import 'Menu.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListarUsuarios extends StatefulWidget {
  const ListarUsuarios({Key? key}) : super(key: key);

  @override
  State<ListarUsuarios> createState() => _ListarUsuariosState();
}

class _ListarUsuariosState extends State<ListarUsuarios> {
  Future<List<Usuario>> usuarios() async {
    var url =
        Uri.parse('https://testegoooo.000webhostapp.com/mostra_clientes.php');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      List<Usuario> posts = List<Usuario>.from(
        //validar null
          json.decode(response.body).map((model) => Usuario.fromJson(model))
      );


      return posts;
    } else {
      throw Exception('Erro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Menu(),
        appBar: AppBar(
          backgroundColor: CompanyColors.primaryPurple,
          title: Text('Usuários'),
        ),
        body: SingleChildScrollView(
    child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Increase volume by 10',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Cadastrar()),
                );
              },
            ),
            FutureBuilder<List<Usuario>>(
              future: usuarios(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Usuario>> snapshot) {
                List<Widget> children;
                if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ];
                }

                if (snapshot.hasData) {
                  print("ok");
                  children = <Widget>[
                    DataTable(
                        columns: [
                          DataColumn(label: Text(
                              'ID',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                          )),
                          DataColumn(label: Text(
                              'Name',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                          )),
                          DataColumn(label: Text(
                              'Profession',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                          )),
                        ],
                      rows: snapshot.data!.map(
                            (user) => DataRow(
                          cells: [
                            DataCell(Text(user.id.toString())),
                            DataCell(Text(user.nome)),
                            DataCell(Text(user.senha)),
                          ],
                        ),
                      )
                          .toList(),
                        )
                  ];
                }else{
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
          ],
        )
    )
    );
  }
}
