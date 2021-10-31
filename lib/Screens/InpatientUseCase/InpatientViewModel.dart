import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';

class InpatientViewModel {
  MaterialColor checkInpatient(BedData bedInfo, int index) {
    switch (index) {
      case 0:
        if (bedInfo.fr <= 8 || bedInfo.fr >= 25) {
          return Colors.red;
        } else if (bedInfo.fr >= 21 && bedInfo.fr <= 24) {
          return Colors.yellow;
        } else if (bedInfo.fr >= 9 && bedInfo.fr <= 11) {
          return Colors.blue;
        } else {
          return Colors.green;
        }
        break;

      case 1:
        if (bedInfo.fc <= 40 || bedInfo.fc >= 131) {
          return Colors.red;
        } else if (bedInfo.fc >= 111 && bedInfo.fc <= 130) {
          return Colors.yellow;
        } else if (bedInfo.fc >= 41 && bedInfo.fc <= 50 ||
            bedInfo.fc >= 91 && bedInfo.fc <= 110) {
          return Colors.blue;
        } else {
          return Colors.green;
        }
        break;

      case 2:
        if (bedInfo.te <= 35.0) {
          return Colors.red;
        } else if (bedInfo.te >= 39.1) {
          return Colors.yellow;
        } else if (bedInfo.te >= 35.1 && bedInfo.te <= 36.0 ||
            bedInfo.te >= 38.1 && bedInfo.te <= 39.0) {
          return Colors.blue;
        } else {
          return Colors.green;
        }
        break;

      case 3:
        if (bedInfo.so >= 91) {
          return Colors.red;
        } else if (bedInfo.so >= 92 && bedInfo.so <= 93) {
          return Colors.yellow;
        } else if (bedInfo.so >= 94 && bedInfo.so <= 95) {
          return Colors.blue;
        } else {
          return Colors.green;
        }
        break;
    }
    return Colors.grey;
  }

  String setTitle(int index) {
    switch (index) {
      case 0:
        return "Frequência Respiratoria";
        break;
      case 1:
        return "Frequência Cardiaca";
        break;
      case 2:
        return "Temperatura";
        break;
      default:
        return "Oxigênio";
        break;
    }
  }

  Image setIcon(int index) {
    switch (index) {
      case 0:
        return Image.asset('assets/images/respiratoryFreq.png',
            height: 40, width: 40);
        break;
      case 1:
        return Image.asset('assets/images/pulse.png', height: 40, width: 40);
        break;
      case 2:
        return Image.asset('assets/images/temperature.png',
            height: 40, width: 40);
        break;
      default:
        return Image.asset('assets/images/respiratoryFreq.png',
            height: 40, width: 40);
        break;
    }
  }

  dynamic setDisplayData(BedProvider model, String bedId, int index) {
    switch (index) {
      case 0:
        return model.holder[bedId].last.fr.toString();
        break;
      case 1:
        return model.holder[bedId].last.fc.toString();
        break;
      case 2:
        return model.holder[bedId].last.te.toString();
        break;
      default:
        return model.holder[bedId].last.so.toString();
        break;
    }
  }

  String detailsTitle(int index) {
    switch (index) {
      case 0:
        return "Frequência Respiratoria";
        break;
      case 1:
        return "Frequência Cardiaca";
        break;
      case 2:
        return "Temperatura";
        break;
      case 3:
        return "Oxigênio";
        break;
    }
    return "";
  }
}