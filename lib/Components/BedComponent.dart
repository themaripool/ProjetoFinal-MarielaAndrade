import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/API/BedDataList.dart';
import 'package:projeto_final_1/Components/LevelComponent.dart';


class BedComponent extends StatelessWidget {
  final int index;
  final BedData bedInfo;
  final Function updateCallback;
  final Function deleteCallback;

  BedComponent({
    this.index,
    this.bedInfo,
    this.updateCallback,
    this.deleteCallback,
  });

  @override
   Widget build(BuildContext context) {
    return Container(
      height: 177.0,
      width: 130.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 4), color: Colors.grey[850]),
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
              Text(bedInfo.so.toString(), style: TextStyle(fontSize: 12, color: Colors.white))
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
              Text(bedInfo.fr.toString(), style: TextStyle(fontSize: 12, color: Colors.white))
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 1),
            child: LevelComponentWidget(Colors.green),
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
