import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Components/LevelComponent.dart';

class BedComponent extends StatefulWidget {
  final String bedNumber;
  final Color color;

  BedComponent(this.bedNumber, this.color);

  @override
  _BedComponentState createState() =>
      _BedComponentState(this.bedNumber, this.color);
}

class _BedComponentState extends State<BedComponent> {
  final String bedNumber;
  final Color color;
  _BedComponentState(this.bedNumber, this.color);
  //  {
  //   this.icon,
  //   this.iconSize = 64,
  //   this.fontSize = 24,
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 177.0,
      width: 130.0,
      decoration: BoxDecoration(
          border: Border.all(color: color, width: 4), color: Colors.grey[850]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8),
            child: Text(
              bedNumber,
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
              Text("60 bpm",
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
              Text("79%", style: TextStyle(fontSize: 12, color: Colors.white))
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
              Text("36.1 C",
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
              Text("12pm", style: TextStyle(fontSize: 12, color: Colors.white))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 1),
            child: LevelComponentWidget(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Text("SEVERO",
                style: TextStyle(fontSize: 12, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
