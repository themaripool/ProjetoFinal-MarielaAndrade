import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientPage/Models/news2.dart';
import 'package:provider/provider.dart';

class InpatientHomeComponent extends StatefulWidget {
  final Color severitycolor;
  final String title;
  final String cardCase;

  InpatientHomeComponent(this.severitycolor, this.title, this.cardCase);

  @override
  _InpatientHomeComponentState createState() => _InpatientHomeComponentState(
      this.severitycolor, this.title, this.cardCase);
}

class _InpatientHomeComponentState extends State<InpatientHomeComponent> {
  final Color severitycolor;
  final String title;
  final String cardCase;

  _InpatientHomeComponentState(this.severitycolor, this.title, this.cardCase);

  var icon;

  @override
  Widget build(BuildContext context) {
    switch (cardCase) {
      case "respiratoryFreq":
        icon = Image.asset('assets/images/respiratoryFreq.png',
            height: 40, width: 40);
        break;
      case "bloodPressure":
        icon = Image.asset('assets/images/bloodPressure.png',
            height: 32, width: 32);
        break;
      case "pulse":
        icon = Image.asset('assets/images/pulse.png', height: 40, width: 40);
        break;
      case "conscience":
        icon = Icon(Icons.face, size: 32);
        break;
      case "temperature":
        icon =
            Image.asset('assets/images/temperature.png', height: 40, width: 40);
        break;
      default:
        icon = Icon(Icons.airplay, size: 32);
        break;
    }

    return Container(
      height: 160.0,
      width: 130.0,
      decoration: BoxDecoration(
          border: Border.all(
              color: severitycolor == Colors.grey
                  ? Colors.grey[300]
                  : severitycolor,
              width: 4),
          borderRadius: new BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Padding(
              padding: const EdgeInsets.all(8),
              child: Consumer<News2>(builder: (context, val, child) {
                switch (cardCase) {
                  case "respiratoryFreq":
                    return Text(val.toStringRespiratoryFreq());
                    break;
                  case "bloodPressure":
                    return Text(val.toStringBloodPressure());
                    break;
                  case "pulse":
                    return Text(val.toStringPulse());
                    break;
                  case "conscience":
                    return Text(val.toStringConscience());
                    break;
                  case "temperature":
                    return Text(val.toStringTemperature());
                    break;
                  case "sp":
                    return Text(val.toStringSp());
                    break;
                }
              })),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

