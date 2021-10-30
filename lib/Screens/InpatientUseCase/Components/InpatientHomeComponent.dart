import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';

var color;

void checkInpatient(BedData bedInfo) {
  if (bedInfo.fr <= 8 ||
      bedInfo.fr >= 25 ||
      bedInfo.so >= 91 ||
      bedInfo.fc <= 40 ||
      bedInfo.fc >= 131 ||
      bedInfo.te <= 35.0) {
    color = Colors.red;
    return;
  } else if (bedInfo.fr >= 21 && bedInfo.fr <= 24 ||
      bedInfo.so >= 92 && bedInfo.so <= 93 ||
      bedInfo.fc >= 111 && bedInfo.fc <= 130 ||
      bedInfo.te >= 39.1) {
    color = Colors.yellow;
    return;
  } else if (bedInfo.fr >= 9 && bedInfo.fr <= 11 ||
      bedInfo.so >= 94 && bedInfo.so <= 95 ||
      bedInfo.fc >= 41 && bedInfo.fc <= 50 ||
      bedInfo.fc >= 91 && bedInfo.fc <= 110 ||
      bedInfo.te >= 35.1 && bedInfo.te <= 36.0 ||
      bedInfo.te >= 38.1 && bedInfo.te <= 39.0) {
    color = Colors.blue;
    return;
  } else if (bedInfo.fr >= 12 && bedInfo.fr <= 20) {
    color = Colors.green;
    return;
  }
}

// ignore: must_be_immutable
class InpatientHomeComponent extends StatelessWidget {
  final int index;
  final String bedId;

  InpatientHomeComponent(this.index, this.bedId);

  var icon;
  var title;
  var displayData;

  @override
  Widget build(BuildContext context) {
    return Consumer<BedProvider>(builder: (__, model, _) {
      checkInpatient(model.holder[bedId].last);
      switch (index) {
        case 0:
          icon = Image.asset('assets/images/respiratoryFreq.png',
              height: 40, width: 40);
          title = "Frequencia Respiratoria";
          displayData = model.holder[bedId].last.fr.toString();
          break;
        case 1:
          icon = Image.asset('assets/images/pulse.png', height: 40, width: 40);
          title = "Frequencia Cardiaca";
          displayData = model.holder[bedId].last.fc.toString();
          break;
        case 2:
          icon = Image.asset('assets/images/temperature.png',
              height: 40, width: 40);
          title = "Temperatura";
          displayData = model.holder[bedId].last.te.toString();
          break;
        default:
          icon = Icon(Icons.airplay, size: 32);
          title = "Oxigênio";
          displayData = model.holder[bedId].last.so.toString();
          break;
      }
      return Container(
          height: 160.0,
          width: 130.0,
          decoration: BoxDecoration(
              border: Border.all(
                  color: color,
                  width: 4),
              borderRadius: new BorderRadius.all(Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Padding(
                  padding: const EdgeInsets.all(8), child: Text(displayData)),
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ));
    });
  }
}
