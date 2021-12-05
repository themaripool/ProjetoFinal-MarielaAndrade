/*
  InpatientViewModel: Funções auxiliares do caso de uso do paciente:
    - showToast: mostra pro usuário um toast de confirmação de dados salvos
    - saveData: Salva dados dos sintomas no firebase
    - checkInpatient: Retorna a cor de acordo com a severidade dos dados recebidos
    - setTitle: Retorna o título de acordo com o index recebido
    - setIcon: Retorna o ícone de acordo com o index recebido
    - setDisplayData: Retorna qual dado será exibido no gráfico
    - detailsTitle: Retorna título da página de detalhes
*/

import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';

class InpatientViewModel {
  void setConscienceLevel(BuildContext context, String val) {
    if (val == null) {
      val = "Dado não inserido";
    }
    Provider.of<Symptoms>(context, listen: false).setConscienceVal(val);
  }

  void setOxLevel(BuildContext context, String val) {
    if (val == null) {
      val = "Dado não inserido";
    }
    Provider.of<Symptoms>(context, listen: false).setSupOxVal(val);
  }

  void setOther(BuildContext context, String val) {
    if (val == "") {
      val = "Dado não inserido";
    }
    Provider.of<Symptoms>(context, listen: false).setOtherVal(val);
  }

  void setHeadache(BuildContext context, int val) {
    Provider.of<Symptoms>(context, listen: false).setHeadacheVal(val);
  }

  void setTiredness(BuildContext context, int val) {
    Provider.of<Symptoms>(context, listen: false).setTirednessVal(val);
  }

  void setPain(BuildContext context, int val) {
    Provider.of<Symptoms>(context, listen: false).setPainVal(val);
  }

  void setNausea(BuildContext context, int val) {
    Provider.of<Symptoms>(context, listen: false).setNauseaVal(val);
  }

  void setDiarrhea(BuildContext context, int val) {
    Provider.of<Symptoms>(context, listen: false).setDiarrheaVal(val);
  }

  void showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Dados Salvos'),
        action: SnackBarAction(
            label: 'ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void saveData(BuildContext context, String numberBed) {
    final _platform = Theme.of(context).platform;

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(DateTime.now().toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var formattedDate = outputFormat.format(inputDate);

    var formattedDateHora = _platform == TargetPlatform.iOS
        ? DateFormat.Hm().format(DateTime.now())
        : DateFormat.Hm().format(DateTime.now().subtract(Duration(hours: 3)));

    var headache = Provider.of<Symptoms>(context, listen: false).headacheVal.toString() == "-1" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).headacheVal.toString();
    var nausea =
        Provider.of<Symptoms>(context, listen: false).nauseaVal.toString() == "-1" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).nauseaVal.toString();
    var tiredness =
        Provider.of<Symptoms>(context, listen: false).tirednessVal.toString() == "-1" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).tirednessVal.toString();
    var diarrhea =
        Provider.of<Symptoms>(context, listen: false).diarrheaVal.toString() == "-1" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).diarrheaVal.toString() ;
    var pain = Provider.of<Symptoms>(context, listen: false).painVal.toString() == "-1" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).painVal.toString();
    var other =
        Provider.of<Symptoms>(context, listen: false).otherVal.toString() == "" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).otherVal.toString() ;
    var ox = Provider.of<Symptoms>(context, listen: false).supOx.toString() == "" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).supOx.toString();
    var conscience =
        Provider.of<Symptoms>(context, listen: false).conscience.toString() ==  "" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).conscience.toString() ;
    var user = Provider.of<BedProvider>(context, listen: false)
        .currentUserName;

    PostgresDao().saveSymptom(conscience, diarrhea, formattedDate, headache,
        formattedDateHora, nausea, other, ox, pain, tiredness, user, numberBed);

    showToast(context);
  }

  void saveDataWeb(BuildContext context, String numberBed) {
    final _platform = Theme.of(context).platform;

    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(DateTime.now().toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    var formattedDate = outputFormat.format(inputDate);

    var formattedDateHora = _platform == TargetPlatform.iOS
        ? DateFormat.Hm().format(DateTime.now())
        : DateFormat.Hm().format(DateTime.now().subtract(Duration(hours: 3)));

    var headache = Provider.of<Symptoms>(context, listen: false).headacheVal.toString() == "-1" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).headacheVal.toString();
    var nausea =
        Provider.of<Symptoms>(context, listen: false).nauseaVal.toString() == "-1" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).nauseaVal.toString();
    var tiredness =
        Provider.of<Symptoms>(context, listen: false).tirednessVal.toString() == "-1" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).tirednessVal.toString();
    var diarrhea =
        Provider.of<Symptoms>(context, listen: false).diarrheaVal.toString() == "-1" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).diarrheaVal.toString() ;
    var pain = Provider.of<Symptoms>(context, listen: false).painVal.toString() == "-1" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).painVal.toString();
    var other =
        Provider.of<Symptoms>(context, listen: false).otherVal.toString() == "" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).otherVal.toString() ;
    var ox = Provider.of<Symptoms>(context, listen: false).supOx.toString() == "" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).supOx.toString();
    var conscience =
        Provider.of<Symptoms>(context, listen: false).conscience.toString() ==  "" ? "dados nao inseridos" : Provider.of<Symptoms>(context, listen: false).conscience.toString() ;
    var user = Provider.of<BedProvider>(context, listen: false)
        .currentUserName;

    MQTTManagerWeb().insertSymptomsQuery('insertSymptoms', conscience, diarrhea, formattedDate, headache,
        formattedDateHora, nausea, other, ox, pain, tiredness, user, numberBed);

    showToast(context);
  }

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
        if (bedInfo.so <= 91) {
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
            height: 40, width: 40, color: Colors.white,);
        break;
      case 1:
        return Image.asset('assets/images/pulse.png', height: 40, width: 40, color: Colors.white,);
        break;
      case 2:
        return Image.asset('assets/images/temperature.png',
            height: 40, width: 40, color: Colors.white,);
        break;
      default:
        return Image.asset('assets/images/airIcon.png', height: 40, width: 40, color: Colors.white,);
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
