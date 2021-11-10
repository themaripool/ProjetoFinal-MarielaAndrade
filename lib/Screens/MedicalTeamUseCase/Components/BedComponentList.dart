import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/GeneralUseCase.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/config.dart';
import '../MedicalTeamUseCase.dart';

var status;
class BedComponentList extends StatelessWidget {
  final BedData bedInfo;

  BedComponentList({this.bedInfo});
  var viewModel = MedicalTeamViewModel();

  @override
  Widget build(BuildContext context) {
    status = viewModel.checkInpatientStatusGrid(bedInfo);

    return Container(
      height: 120.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "LEITO ${bedInfo.bedNumber}",
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
                  Text(bedInfo.fc.toString(),
                      style: TextStyle(fontSize: 14)),
                  Spacer(),
                  Text("SaO2: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text(bedInfo.so.toString(),
                      style: TextStyle(fontSize: 14)),
                  Spacer(),
                  Text("Temp: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text(bedInfo.te.toString(),
                      style: TextStyle(fontSize: 14)),
                  Spacer(),
                  Text("FR: ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text(bedInfo.fr.toString(),
                      style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            Row(
              children: [
                LevelComponentWidget(status[0]),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child:
                      Text(status[1], style: TextStyle(fontSize: 14)),
                ),
                Spacer(),
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BedDetails(bedInfo.bedNumber.toString(), 1);
                        }));
                    },
                    child: const Text('Alarmes', style: TextStyle(color: Colors.black),))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
