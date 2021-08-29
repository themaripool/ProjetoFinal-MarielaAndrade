import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientPage/Models/symptoms.dart';
import 'package:projeto_final_1/Screens/Login.dart';
import 'package:provider/provider.dart';



void main() => runApp(ChangeNotifierProvider(
      create: (context) => Symptoms(0, 0, 0, 0, 0, ""),
      child: TccApp(),
    ));

class TccApp extends StatelessWidget {
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

