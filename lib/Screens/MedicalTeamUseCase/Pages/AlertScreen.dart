import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/DAO/alarmsDAO.dart';
import 'package:projeto_final_1/Models/AlertModel.dart';
import '../Components/AlertComponentList.dart';

class AlertScreen extends StatelessWidget {
  final String bedNumber;

  const AlertScreen({Key key, this.bedNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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

