import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';
import 'package:projeto_final_1/WebAppFiles/detailsWeb.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';

var bedSeverityStatus;
var bedSeverityColor;
const TWO_PI = 3.14 * 2;

void checkInpatientStatus(String clinicalStatus) {
  if (clinicalStatus == "1") {
    bedSeverityStatus = "CRÍTICO";
    bedSeverityColor = Colors.red[700];
    return;
  } else if (clinicalStatus == "2") {
    bedSeverityStatus = "SEVERO";
    bedSeverityColor = Colors.yellow[700];
    return;
  } else if (clinicalStatus == "3") {
    bedSeverityStatus = "PREOCUPANTE";
    bedSeverityColor = Colors.blue[700];
    return;
  } else if (clinicalStatus == "4") {
    bedSeverityStatus = "ESTÁVEL";
    bedSeverityColor = Colors.green[700];
    return;
  }
}

class AlertDialogWeb extends StatelessWidget {
  final String bedId;
  final dynamic content;
  final String clinicalStatus;

  AlertDialogWeb(this.clinicalStatus, this.bedId, this.content);

  @override
  Widget build(BuildContext context) {
    checkInpatientStatus(clinicalStatus);
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: [
        Container(
          width: 210,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: bedSeverityColor,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AlertCloseButton(),
                AlertTitle(bedId: bedId),
                Image.asset('assets/images/warningIcon.png',
                    height: 60, width: 60),
                AlertInfoLabel(
                  content: content,
                ),
                AlertInfoDetails(
                  content: content,
                ),
                AlertButtons(
                  bedId: bedId,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}