import 'package:flutter/material.dart';
import 'package:projeto_final_1/WebAppFiles/detailsWeb.dart';

import '../mqttManagerWeb.dart';

class AlertButtons extends StatelessWidget {
  final String bedId;
  const AlertButtons({
    Key key,
    this.bedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey[900])),
              onPressed: () {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPageWeb(bedId, -1),
                    ));
              },
              child: Text("VER DADOS", style: TextStyle(color: Colors.white))),
          OutlinedButton(
              style: ButtonStyle(
                side:
                    MaterialStateProperty.all(BorderSide(color: Colors.black)),
              ),
              onPressed: () {
                //MQTTManagerWeb().send_alarm_recognition(bedId);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Column(
                    children: [
                      Text("CONFERIR", style: TextStyle(color: Colors.black)),
                      Text("PACIENTE", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Icon(
                    Icons.done,
                    color: Colors.black,
                    size: 24,
                  )
                ],
              ))
        ],
      ),
    );
  }
}