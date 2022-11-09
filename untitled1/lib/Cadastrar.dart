import 'dart:convert';

import 'package:calculadora/model/Usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Layout.dart';
import 'ListarUsuarios.dart';
import 'Menu.dart';

class Cadastrar extends StatefulWidget {
  const Cadastrar({Key? key}) : super(key: key);

  @override
  State<Cadastrar> createState() => _CadastrarState();
}

class _CadastrarState extends State<Cadastrar> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();

  Future cadastrar() async {
    var url = Uri.parse('https://testegoooo.000webhostapp.com/cadastro.php');

    var map = new Map<String, dynamic>();
    map['tipo'] = '1,2';
    map['nome'] = nomeController.text;
    map['login'] = loginController.text;
    map['email'] = emailController.text;
    map['senha'] = senhaController.text;

    var response = await http.post(url, body: map);
    print(response.statusCode);
    if (response.statusCode == 200) {
        return response;

    } else {
      return 'erro';
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(),
      appBar: AppBar(
        backgroundColor: CompanyColors.primaryPurple,
        title: Text('Adicionar usuários'),
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    labelText: "Nome",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: loginController,
                  decoration: InputDecoration(
                    labelText: "Login",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: senhaController,
                  decoration: InputDecoration(
                    labelText: "Senha",
                  ),
                  // The validator receives the text that the user has entered
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value != confirmarSenhaController.text) {
                      return 'As senhas não iguais';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: confirmarSenhaController,
                  decoration: InputDecoration(
                    labelText: "Confirmar senha",
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value != senhaController.text) {
                      return 'As senhas não iguais';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: TextButton(
                        onPressed: () async {
                          // Validate returns true if the form is valid, or false otherwise.

                          if (_formKey.currentState!.validate()) {
                            var result = await cadastrar();
                            print(result);
                            if (result.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Cadastrado com sucesso!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ListarUsuarios()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Erro ao cadastrar usuário!'),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor:
                              Color(0xFF5D7A9E), // Background Color
                        ),
                        child: const Text('Cadastrar')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
