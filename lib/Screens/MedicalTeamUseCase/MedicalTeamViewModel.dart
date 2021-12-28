


//so = oxigenio
// fc - frequencia cardiaca == pulso
// te = temperatura
// fr = frequencia respiratoria

import 'package:flutter/material.dart';
import 'package:projeto_final_1/Models/Models.dart';

class MedicalTeamViewModel {

// ignore: missing_return

int checkSeverityBoxes(Color severitycolor) {
  if (severitycolor == Colors.blue) {
    return 2;
  } else if (severitycolor == Colors.yellow) {
    return 3;
  } else if (severitycolor == Colors.red) {
    return 4;
  } else if (severitycolor == Colors.green){
    return 1;
  }
}

List checkInpatientStatusGrid(BedData bedInfo) {
  if (bedInfo.cs == 3) {
    return [Colors.red, "CRÍTICO"];
  } else if (bedInfo.cs == 2){
    return [Colors.yellow, "SEVERO"];
  }else if (bedInfo.cs == 1){
    return [Colors.blue, "PREOCUPANTE"];
  }else if (bedInfo.cs == 0){
    return [Colors.green, "ESTÁVEL"];
  }
}

void showToastConnectionLost(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Perda de conexão com o kit'),
        action: SnackBarAction(
            label: 'ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

}
