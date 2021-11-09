import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';
import '../Components/AlertComponentList.dart';

class AlertScreen extends StatelessWidget {
  final String bedNumber;
  final bool isAllAlarms;

  const AlertScreen({Key key, this.bedNumber, this.isAllAlarms})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isAllAlarms == true) {
      return FutureBuilder<List>(
            future: PostgresDao().getAllAlerts(),
            initialData: List(),
            builder: (context, snapshot) {
              if (snapshot.data.isEmpty) {
                return Center(child: Text("Sem alertas"));
              } else {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, int position) {
                          final alert = snapshot.data[position];
                          return AlertComponentList(
                            alert.dateAndMonth, 
                            alert.hourAndMinute,
                            alert.clinicalStatus,
                            alert.bedId,
                          );
                        },
                      )
                    : Center(child: CircularProgressIndicator());
              }
            },
          );
    } else {
      return FutureBuilder<List>(
            future: PostgresDao().getAlertsByBed(bedNumber),
            initialData: List(),
            builder: (context, snapshot) {
              if (snapshot.data.isEmpty) {
                return Center(child: Text("Este paciente ainda não tem alertas"));
              } else {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, int position) {
                          final alert = snapshot.data[position];
                          return AlertComponentList(
                            alert.dateAndMonth, 
                            alert.hourAndMinute,
                            alert.clinicalStatus,
                            alert.bedId,
                          );
                        },
                      )
                    : Center(child: CircularProgressIndicator());
              }
            },
          );
    }
  }
}
