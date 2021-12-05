/* InpatientSymptomsHistory: TELA DE HISTÓRICO DE SINTOMAS DO PACIENTE
- Mostra histórico de sintomas de acordo com o so
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/GeneralUseCase.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/config.dart';

class InpatientSymptomsHistory extends StatelessWidget {
  final String bedNumber;
  final bool isAllAlarms;
  final bool isInpatient;

  const InpatientSymptomsHistory(
      {Key key, this.bedNumber, this.isAllAlarms, this.isInpatient})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    if (_platform == TargetPlatform.iOS) {
      if (isInpatient) {
        MQTTManager().makePGQuery('SymptomsByUser', bedNumber);
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CupertinoNavigationBar(
              middle: Text("Histórico"),
            ),
            body: Consumer<BedProvider>(builder: (__, model, _) {
              if (model.allSymptomByBed.isEmpty) {
                return Center(
                    child: Text("Este usuário não possui dados salvos"));
              } else {
                return ListView.builder(
                  itemCount: model.allSymptomByBed.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {},
                        child: SymptomsComponentList(
                          model.allSymptomByBed[index].headache,
                          model.allSymptomByBed[index].nausea,
                          model.allSymptomByBed[index].tiredness,
                          model.allSymptomByBed[index].diarrea,
                          model.allSymptomByBed[index].pain,
                          model.allSymptomByBed[index].others,
                          model.allSymptomByBed[index].hourAndMinute,
                          model.allSymptomByBed[index].formattedDate,
                          model.allSymptomByBed[index].ox,
                          model.allSymptomByBed[index].conscience,
                        ));
                  },
                );
              }
            }));
      } else {
        MQTTManager().makePGQuery('SymptomsByBed', bedNumber);
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CupertinoNavigationBar(
              middle: Text("Histórico"),
            ),
            body: Consumer<BedProvider>(builder: (__, model, _) {
              if (model.allSymptomByBed.isEmpty) {
                return Center(child: Text("Sem dados salvos nesta cama"));
              } else {
                return ListView.builder(
                  itemCount: model.allSymptomByBed.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {},
                        child: SymptomsComponentList(
                          model.allSymptomByBed[index].headache,
                          model.allSymptomByBed[index].nausea,
                          model.allSymptomByBed[index].tiredness,
                          model.allSymptomByBed[index].diarrea,
                          model.allSymptomByBed[index].pain,
                          model.allSymptomByBed[index].others,
                          model.allSymptomByBed[index].hourAndMinute,
                          model.allSymptomByBed[index].formattedDate,
                          model.allSymptomByBed[index].ox,
                          model.allSymptomByBed[index].conscience,
                        ));
                  },
                );
              }
            }));
      }
    }
    // android
    else if (_platform == TargetPlatform.android) {
      if (isInpatient) {
        MQTTManager().makePGQuery('SymptomsByUser', bedNumber);
        return MaterialApp(
            theme: SwitchProvider.lightTheme,
            darkTheme: SwitchProvider.darkTheme,
            themeMode: currentTheme.currentTheme,
            home: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                    title: Text("Histórico"),
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    )),
                body: Consumer<BedProvider>(builder: (__, model, _) {
                  if (model.allSymptomByBed.isEmpty) {
                    return Center(
                        child: Text("Este usuário não possui dados salvos"));
                  } else {
                    return ListView.builder(
                      itemCount: model.allSymptomByBed.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: () {},
                            child: SymptomsComponentList(
                              model.allSymptomByBed[index].headache,
                              model.allSymptomByBed[index].nausea,
                              model.allSymptomByBed[index].tiredness,
                              model.allSymptomByBed[index].diarrea,
                              model.allSymptomByBed[index].pain,
                              model.allSymptomByBed[index].others,
                              model.allSymptomByBed[index].hourAndMinute,
                              model.allSymptomByBed[index].formattedDate,
                              model.allSymptomByBed[index].ox,
                              model.allSymptomByBed[index].conscience,
                            ));
                      },
                    );
                  }
                })));
      } else {
        MQTTManager().makePGQuery('SymptomsByBed', bedNumber);
        return MaterialApp(
            theme: SwitchProvider.lightTheme,
            darkTheme: SwitchProvider.darkTheme,
            themeMode: currentTheme.currentTheme,
            home: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                    title: Text("Histórico"),
                    leading: new IconButton(
                      icon: new Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    )),
                body: Consumer<BedProvider>(builder: (__, model, _) {
                  if (model.allSymptomByBed.isEmpty) {
                    return Center(child: Text("Sem dados salvos nesta cama"));
                  } else {
                    return ListView.builder(
                      itemCount: model.allSymptomByBed.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SymptomsComponentList(
                          model.allSymptomByBed[index].headache,
                          model.allSymptomByBed[index].nausea,
                          model.allSymptomByBed[index].tiredness,
                          model.allSymptomByBed[index].diarrea,
                          model.allSymptomByBed[index].pain,
                          model.allSymptomByBed[index].others,
                          model.allSymptomByBed[index].hourAndMinute,
                          model.allSymptomByBed[index].formattedDate,
                          model.allSymptomByBed[index].ox,
                          model.allSymptomByBed[index].conscience,
                        );
                      },
                    );
                  }
                })));
      }
    }
  }
}

class SymptomsComponentList extends StatelessWidget {
  final String headache;
  final String nausea;
  final String tiredness;
  final String diarrea;
  final String pain;
  final String others;
  final String hourAndMinute;
  final String formattedDate;
  final String ox;
  final String conscience;
  SymptomsComponentList(
      this.headache,
      this.nausea,
      this.tiredness,
      this.diarrea,
      this.pain,
      this.others,
      this.hourAndMinute,
      this.formattedDate,
      this.ox,
      this.conscience);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.0,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(children: [
                  Text(formattedDate,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text(hourAndMinute,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
              Text("Dor de Cabeça: $headache",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              Text("Nausea: $nausea",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              Text("Cansaço $tiredness",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              Text("Diarreia: $diarrea",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              Text("Dor: $pain",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              Text("Outros: $others",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              Text("Suplemento de ox?: $ox",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
              Text("Consciência: $conscience",
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
          )),
    );
  }
}
