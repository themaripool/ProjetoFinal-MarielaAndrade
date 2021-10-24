import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Models/Models.dart';
import '../MedicalTeamUseCase.dart';

var bedSeverityColor;
var bedSeverityStatus;

void checkInpatientStatus(BedData bedInfo) {
  if (bedInfo.fr <= 8 || 
      bedInfo.fr >= 25 || 
      bedInfo.so >= 91 || 
      bedInfo.fc <= 40 || 
      bedInfo.fc >= 131 || 
      bedInfo.te <= 35.0) {

    bedSeverityColor = Colors.red;
    bedSeverityStatus = "CRÍTICO";
    return;

  } else if (
      bedInfo.fr >= 21 && bedInfo.fr <= 24 || 
      bedInfo.so >= 92 && bedInfo.so <= 93 || 
      bedInfo.fc >= 111 && bedInfo.fc <= 130 ||
      bedInfo.te >= 39.1){

    bedSeverityColor = Colors.yellow;
    bedSeverityStatus = "SEVERO";
    return;

  }else if (bedInfo.fr >= 9 && bedInfo.fr <= 11 || 
            bedInfo.so >= 94 && bedInfo.so <= 95 || 
            bedInfo.fc >= 41 && bedInfo.fc <= 50 || 
            bedInfo.fc >= 91 && bedInfo.fc <= 110|| 
            bedInfo.te >= 35.1 && bedInfo.te <= 36.0 ||
            bedInfo.te >= 38.1 && bedInfo.te <= 39.0){

    bedSeverityColor = Colors.blue;
    bedSeverityStatus = "PREOCUPANTE";
    return;

  }else if (bedInfo.fr >= 12 && bedInfo.fr <= 20){

    bedSeverityColor = Colors.green;
    bedSeverityStatus = "ESTÁVEL";
    return;
    
  }
}

class BedComponentList extends StatelessWidget {
 final BedData bedInfo;

  BedComponentList({this.bedInfo});

  @override
  Widget build(BuildContext context){
    checkInpatientStatus(bedInfo);
    return Container(
      height: 100.0,
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text("LEITO ${bedInfo.bedNumber}"
                ,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Text("FC: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text(bedInfo.fc.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                  Spacer(),
                  Text("SaO2: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text(bedInfo.so.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                  Spacer(),
                  Text("Temp: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text(bedInfo.te.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                  Spacer(),
                  Text("FR: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Text(bedInfo.fr.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
            ),
            Row(
              children: [
                LevelComponentWidget(bedSeverityColor),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(bedSeverityStatus, style: TextStyle(fontSize: 14)),
                ),
                Spacer(),
                Text("Alarmes")
              ],
            )
          ],
        ),
      ),
    );
  }
}

