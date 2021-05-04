import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/Login.dart';



void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[850],
        accentColor: Colors.green,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.indigo,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Login(),
    );
  }
}

