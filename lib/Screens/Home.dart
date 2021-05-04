import 'package:flutter/material.dart';
import 'package:projeto_final_1/Components/DrawerMenu.dart';
import 'package:projeto_final_1/Screens/Settings.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  final appTitle = 'ENFERMARIA 1';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: Settings(),//HomePage(title: appTitle),
      theme: ThemeData(primaryColor: Color.fromRGBO(236, 234, 234, 1.0)),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;
  HomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      drawer: DrawerMenu(),
      body: Center(child: Text('Dashboard de pacientes')),
    );
  }
}