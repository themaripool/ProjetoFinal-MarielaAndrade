import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Components/LevelComponent.dart';

class BedComponentList extends StatefulWidget {
  final String bedNumber;
  final Color color;
  final Color severitycolor;
  final String severityState;

  BedComponentList(
      this.bedNumber, this.color, this.severitycolor, this.severityState);

  @override
  _BedComponentListState createState() => _BedComponentListState(
      this.bedNumber, this.color, this.severitycolor, this.severityState);
}

class _BedComponentListState extends State<BedComponentList> {
  final String bedNumber;
  final Color color;
  final Color severitycolor;
  final String severityState;

  _BedComponentListState(
      this.bedNumber, this.color, this.severitycolor, this.severityState);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                bedNumber,
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
                          fontWeight: FontWeight.bold)),
                  Text("60 bpm",
                      style: TextStyle(fontSize: 14)),
                  Spacer(),
                  Text("SaO2: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text("79%",
                      style: TextStyle(fontSize: 14)),
                  Spacer(),
                  Text("Temp: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text("36.1 C",
                      style: TextStyle(fontSize: 14)),
                  Spacer(),
                  Text("FR: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text("12pm",
                      style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            Row(
              children: [
                LevelComponentWidget(severitycolor),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(severityState, style: TextStyle(fontSize: 14)),
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
