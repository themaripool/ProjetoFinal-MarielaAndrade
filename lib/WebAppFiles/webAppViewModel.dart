import 'package:flutter/material.dart';

class WebAppViewModel {
  String checkClinicalStatus(String status) {
    if (status == '0') {
      return 'Estável';
    } else if (status == '1') {
      return 'Preocupante';
    } else if (status == '2') {
      return 'Severo';
    } else {
      return 'Crítico';
    }
  }

  List checkInpatientStatus(String clinicalStatus) {
    if (clinicalStatus == "3") {
      return [Colors.red, "CRÍTICO"];
    } else if (clinicalStatus == "2") {
      return [Colors.yellow, "SEVERO"];
    } else if (clinicalStatus == "1") {
      return [Colors.blue, "PREOCUPANTE"];
    } else if (clinicalStatus == "0") {
      return [Colors.green, "ESTÁVEL"];
    } else {
      return [];
    }
  }
}
