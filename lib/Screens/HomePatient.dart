import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/PatientData.dart';
import 'package:projeto_final_1/Screens/PatientSymptoms.dart';

class HomePatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[700],
            title: Text("Bem Vindo(a) Pessoa"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.addchart_sharp),
                  text: "DADOS",
                ),
                Tab(
                  icon: Icon(Icons.analytics_outlined),
                  text: "SINTOMAS",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[PatientData(), PatientSymptoms()],
          )),
    ));
  }
}
