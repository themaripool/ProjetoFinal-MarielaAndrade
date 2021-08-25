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
            actions: [
              IconButton(
                icon: Icon(Icons.notifications_none),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Alert2Widget();
                    },
                  );
                },
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/c9/85/9c/c9859c3719f1328d1795df856940ddfd.jpg'),
                radius: 18.0,
              ),
            ],
            backgroundColor: Colors.grey[700],
            title: Text(
              "Bem Vindo John Doe",
              style: TextStyle(color: Colors.grey[350]),
            ),
            // bottom: TabBar(
            //   tabs: <Widget>[
            //     Tab(
            //       icon: Icon(Icons.addchart_sharp),
            //       text: "DADOS",
            //     ),
            //     Tab(
            //       icon: Icon(Icons.analytics_outlined),
            //       text: "SINTOMAS",
            //     )
            //   ],
            // ),
          ),
          body: PatientData()
          // TabBarView(
          //   children: <Widget>[PatientData(), PatientSymptoms()],
          // )
          ),
    ));
  }
}
