import 'package:flutter/material.dart';

enum News2Enum {
  respiratoryFreq, //frequencia respiratoria
  bloodPressure, //pressao arterial
  pulse, //pulso 
  conscience, //consciencia
  temperature, //temperatura
  sp, //sp 02
}

class InpatientHomeComponent extends StatefulWidget {
  final Color severitycolor;
  final String title;
  final String description;
  final String cardCase;

  InpatientHomeComponent(this.severitycolor, this.title, this.description, this.cardCase);

  @override
  _InpatientHomeComponentState createState() => _InpatientHomeComponentState(
      this.severitycolor, this.title, this.description, this.cardCase);
}

class _InpatientHomeComponentState extends State<InpatientHomeComponent> {
  final Color severitycolor;
  final String title;
  final String description;
  final String cardCase;

  _InpatientHomeComponentState(this.severitycolor, this.title, this.description, this.cardCase);

  var icon;

  @override
  Widget build(BuildContext context) {

  switch (cardCase) {
      case "respiratoryFreq":
        icon = Image.asset('assets/images/respiratoryFreq.png',height: 40, width: 40);
        break;
      case "bloodPressure":
        icon = Image.asset('assets/images/bloodPressure.png',height: 40, width: 40);
        break;
      case "pulse":
        icon = Image.asset('assets/images/pulse.png',height: 40, width: 40);
        break;
      case "conscience":
        icon = Icon(Icons.face, size: 32);
        break;
      case "temperature":
        icon = Image.asset('assets/images/temperature.png',height: 40, width: 40);
        break;
      default:
        icon = Icon(Icons.air, size: 32);
        break;
    }





    return Container(
      height: 160.0,
      width: 130.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200], width: 4),
          color: severitycolor,
          borderRadius: new BorderRadius.all(Radius.circular(15))
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Padding( padding: const EdgeInsets.all(8), child: Text(description, style: TextStyle(fontSize: 24, color: Colors.black)),),
          Padding(padding: const EdgeInsets.all(8), child: Text(title, style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),),
        ],
      ),
    );
  }
}
