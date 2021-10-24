import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Models/Models.dart';

import '../MedicalTeamUseCase.dart';

var severityColor;
var severityStatus;

//so = oxigenio
// fc - frequencia cardiaca == pulso
// te = temperatura
// fr = frequencia respiratoria

void checkInpatientStatusGrid(BedData bedInfo) {
  if (bedInfo.fr <= 8 || 
      bedInfo.fr >= 25 || 
      bedInfo.so >= 91 || 
      bedInfo.fc <= 40 || 
      bedInfo.fc >= 131 || 
      bedInfo.te <= 35.0) {

    severityColor = Colors.red;
    severityStatus = "CRÍTICO";
    return;

  } else if (
      bedInfo.fr >= 21 && bedInfo.fr <= 24 || 
      bedInfo.so >= 92 && bedInfo.so <= 93 || 
      bedInfo.fc >= 111 && bedInfo.fc <= 130 ||
      bedInfo.te >= 39.1){

    severityColor = Colors.yellow;
    severityStatus = "SEVERO";
    return;

  }else if (bedInfo.fr >= 9 && bedInfo.fr <= 11 || 
            bedInfo.so >= 94 && bedInfo.so <= 95 || 
            bedInfo.fc >= 41 && bedInfo.fc <= 50 || 
            bedInfo.fc >= 91 && bedInfo.fc <= 110|| 
            bedInfo.te >= 35.1 && bedInfo.te <= 36.0 ||
            bedInfo.te >= 38.1 && bedInfo.te <= 39.0){

    severityColor = Colors.blue;
    severityStatus = "PREOCUPANTE";
    return;

  }else if (bedInfo.fr >= 12 && bedInfo.fr <= 20){

    severityColor = Colors.green;
    severityStatus = "ESTÁVEL";
    return;
    
  }
}

class BedComponent extends StatelessWidget {
  final BedData bedInfo;

  BedComponent({
    this.bedInfo,
  });

  @override
  Widget build(BuildContext context) {
    checkInpatientStatusGrid(bedInfo);

    return Container(
      height: 177.0,
      width: 130.0,
      decoration: BoxDecoration(
          border: Border.all(color: severityColor, width: 4),
          color: Colors.grey[850]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8),
            child: Text(
              "LEITO " + bedInfo.bedNumber.toString(),
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(children: [
              Text("FC: ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(bedInfo.fc.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(children: [
              Text("SaO2: ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(bedInfo.so.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(children: [
              Text("Temp: ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(bedInfo.te.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(children: [
              Text("FR: ",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              Text(bedInfo.fr.toString(),
                  style: TextStyle(fontSize: 12, color: Colors.white))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 1),
            child: LevelComponentWidget(severityColor),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Text(severityStatus,
                style: TextStyle(fontSize: 12, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
