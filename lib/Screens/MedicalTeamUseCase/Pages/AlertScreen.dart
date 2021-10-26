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
      return FirebaseAnimatedList(
        query: AlarmsDao().getAllAlarms(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final alert = Alert.fromJson(json);
          return AlertComponentList(alert.dateAndMonth, alert.hourAndMinute,
              alert.clinicalStatus, alert.bedId);
        },
      );
    } else {
      return FirebaseAnimatedList(
        query: AlarmsDao().getAlarmsByBedQuery(bedNumber),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final alert = Alert.fromJson(json);
          return AlertComponentList(alert.dateAndMonth, alert.hourAndMinute,
              alert.clinicalStatus, alert.bedId);
        },
      );
    }
  }
}
