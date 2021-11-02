import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';

var boxCount = 1;

class LevelComponentWidget extends StatelessWidget {
  final Color severitycolor;
  var viewModel = MedicalTeamViewModel();

  LevelComponentWidget(this.severitycolor);

  @override
  Widget build(BuildContext context) {
    boxCount = viewModel.checkSeverityBoxes(severitycolor);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.5),
              color: boxCount >= 1 ? severitycolor : Colors.grey[600]),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.5),
              color: boxCount >= 2 ? severitycolor : Colors.grey[600]),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.5),
              color: boxCount >= 3 ? severitycolor : Colors.grey[600]),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.5),
              color: boxCount == 4 ? severitycolor : Colors.grey[600]),
        ),
      ],
    );
  }
}
