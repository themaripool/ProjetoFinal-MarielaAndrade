


//so = oxigenio
// fc - frequencia cardiaca == pulso
// te = temperatura
// fr = frequencia respiratoria

import 'package:flutter/material.dart';
import 'package:projeto_final_1/Models/Models.dart';

class MedicalTeamViewModel {

// ignore: missing_return
List checkInpatientStatusGrid(BedData bedInfo) {
  if (bedInfo.fr <= 8 || 
      bedInfo.fr >= 25 || 
      bedInfo.so >= 91 || 
      bedInfo.fc <= 40 || 
      bedInfo.fc >= 131 || 
      bedInfo.te <= 35.0) {

    return [Colors.red, "CRÍTICO"];

  } else if (
      bedInfo.fr >= 21 && bedInfo.fr <= 24 || 
      bedInfo.so >= 92 && bedInfo.so <= 93 || 
      bedInfo.fc >= 111 && bedInfo.fc <= 130 ||
      bedInfo.te >= 39.1){

    return [Colors.yellow, "SEVERO"];

  }else if (bedInfo.fr >= 9 && bedInfo.fr <= 11 || 
            bedInfo.so >= 94 && bedInfo.so <= 95 || 
            bedInfo.fc >= 41 && bedInfo.fc <= 50 || 
            bedInfo.fc >= 91 && bedInfo.fc <= 110|| 
            bedInfo.te >= 35.1 && bedInfo.te <= 36.0 ||
            bedInfo.te >= 38.1 && bedInfo.te <= 39.0){

    return [Colors.blue, "PREOCUPANTE"];

  }else if (bedInfo.fr >= 12 && bedInfo.fr <= 20){

    return [Colors.green, "ESTÁVEL"];
  }
}



}
