import 'package:flutter/material.dart';
import 'dart:convert';
import 'ListarUsuarios.dart';
import 'package:http/http.dart' as http;


// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  TextEditingController loginController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  Future<List> usuario() async{
      var url = Uri.parse('https://testegoooo.000webhostapp.com/processa_login.php');
      Map data = {
        'email': loginController.text,
        'senha': senhaController.text
      };

      var map = new Map<String, dynamic>();
      map['email'] = loginController.text;
      map['senha'] = senhaController.text;

      var response = await http.post(url,body: map);
      print(response.body);
      if (response.statusCode == 200){
        if(!response.bodyBytes.isEmpty){

          return jsonDecode(utf8.decode(response.bodyBytes));
        }
        return response.bodyBytes;
      }else{
        return response.bodyBytes;
      }

  }
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(

    body: Container(
      padding: new EdgeInsets.symmetric(horizontal: 50),
      color: const Color(0xFF5D7A9E),

      child: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: SizedBox(

                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Text(
                          'Login',
                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color(0xFF444444),
                          ),
                        ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          TextFormField(
                            controller:loginController,
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
                            controller:senhaController,
                            decoration: InputDecoration(
                              labelText: "Senha",
                            ),
                            // The validator receives the text that the user has entered
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
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
                                    //usuario();
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    var result = await usuario();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(result.toString()),
                                          behavior: SnackBarBehavior.floating,
                                        )
                                    );
                                    print(result);

                                    if (!result.isEmpty ){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ListarUsuarios()),
                                      );
                                    }
                                  }
                                },
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Color(0xFF5D7A9E), // Background Color
                                ),

                                child: const Text('Login')
                            ),
                          ),
                            ),
                        ],
                      ),
                    ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );

  }
}