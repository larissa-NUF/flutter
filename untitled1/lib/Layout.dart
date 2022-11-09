import 'package:calculadora/ListarUsuarios.dart';
import 'package:flutter/material.dart';

class CompanyColors {
  CompanyColors._();

  static MaterialColor primaryPurple = MaterialColor(
    _purplePrimaryValue,
    <int, Color>{
      50: Color(0xFF5D7A9E),
      100: Color(0xFF000000),
      200: Color(0xFF000000),
      300: Color(0xFF000000),
      400: Color(0xFF000000),
      500: Color(_purplePrimaryValue),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );
  static int _purplePrimaryValue = 0xFF5D7A9E;
}

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: CompanyColors.primaryPurple,
          primaryColor: CompanyColors.primaryPurple,
      ),
      home: ListarUsuarios(),
    );
  }
}
