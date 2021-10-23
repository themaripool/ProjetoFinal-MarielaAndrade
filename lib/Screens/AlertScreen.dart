import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/alarms.dart';
import 'package:projeto_final_1/Data/alarmsDAO.dart';

class AlertScreen extends StatefulWidget {
  final String bedNumber;

  const AlertScreen({Key key, this.bedNumber}) : super(key: key);
  @override
  _AlertScreenState createState() => _AlertScreenState(this.bedNumber);
}

class _AlertScreenState extends State<AlertScreen> {
  final String bedNumber;

  _AlertScreenState(this.bedNumber);

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      query: AlarmsDao().getAlarmsByBedQuery(bedNumber),
      itemBuilder: (context, snapshot, animation, index) {
        final json = snapshot.value as Map<dynamic, dynamic>;
        final alert = AlertModel.fromJson(json);
        return AlertComponentList(alert.dateAndMonth, alert.hourAndMinute,
              alert.clinicalStatus, alert.bedId);
      },
    );
  }
}

class AlertComponentList extends StatefulWidget {
  final String dataEMes;
  final String hora;
  final String bedId;
  final String clinicalStatus;
  AlertComponentList(this.dataEMes, this.hora, this.clinicalStatus, this.bedId);

  @override
  _AlertComponentListState createState() => _AlertComponentListState(
      this.dataEMes, this.hora, this.clinicalStatus, this.bedId);
}

class _AlertComponentListState extends State<AlertComponentList> {
  final String dataEMes;
  final String hora;
  final String bedId;
  final String clinicalStatus;

  _AlertComponentListState(
      this.dataEMes, this.hora, this.clinicalStatus, this.bedId);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(color: Colors.grey[400]),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(dataEMes,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(hora,
                    style: TextStyle(fontSize: 14, color: Colors.black)),
              ),
              Spacer(),
              Text("Cama $bedId",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors
                      .black, //cor == Colors.orange[400].withOpacity(0.4) ? Colors.black : Colors.transparent,
                ),
              ),
              Text(clinicalStatus,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.done,
                  color: Colors
                      .black, //cor == Colors.orange[400].withOpacity(0.4) ? Colors.white : Colors.black,
                ),
              ),
            ],
          )),
    );
  }
}
