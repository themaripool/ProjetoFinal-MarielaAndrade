import 'package:flutter/material.dart';
import 'package:projeto_final_1/Components/AlertDialogPatient.dart';
import 'package:projeto_final_1/Components/DrawerMenu.dart';
import 'package:projeto_final_1/Screens/Settings.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  final appTitle = 'ENFERMARIA 1';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: AlertDialogPatient(), //HomePage(title: appTitle),
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
      body: Center(child: Column(
        children: [
          Text("Tela de dashboard"),

          RaisedButton(onPressed:(){
          //  AlertDialogPatient()
          showDialog(context: context,builder: (contextDialog) {return AlertDialogPatient();});
          })
        ],
      )),
    );
  }
}