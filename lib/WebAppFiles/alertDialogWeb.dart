import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/WebAppFiles/webAppViewModel.dart';
import 'alertComponents.dart/AlertComponents.dart';

/* ==================================================
  Dialog de alerta do leito
===================================================== */

class AlertDialogWeb extends StatelessWidget {
  final String bedId;
  final dynamic content;
  final String clinicalStatus;

  var viewModel = WebAppViewModel();
  var resp = List();

  AlertDialogWeb(this.clinicalStatus, this.bedId, this.content);

  @override
  Widget build(BuildContext context) {
    resp = viewModel.checkInpatientStatus(clinicalStatus);
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: [
        Container(
          width: 210,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: resp[0],
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AlertCloseButton(),
                AlertTitle(
                  bedId: bedId,
                  bedSeverityStatus: resp[1],
                ),
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
