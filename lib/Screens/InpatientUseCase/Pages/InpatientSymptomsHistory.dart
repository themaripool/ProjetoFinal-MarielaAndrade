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
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CupertinoNavigationBar(
            middle: Text("Histórico"),
          ),
          body: FutureBuilder<List>(
            future: PostgresDao().getSymptomsByUser(
                Provider.of<BedProvider>(contextProvider, listen: false)
                    .currentUserName),
            initialData: List(),
            builder: (context, snapshot) {
              if (snapshot.data.isEmpty) {
                return Center(
                    child: Text("Este paciente ainda não salvou sintomas"));
              } else {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, int position) {
                          final symptom = snapshot.data[position];
                          return SymptomsComponentList(
                            symptom.headache,
                            symptom.nausea,
                            symptom.tiredness,
                            symptom.diarrea,
                            symptom.pain,
                            symptom.others,
                            symptom.hourAndMinute,
                            symptom.formattedDate,
                            symptom.ox,
                            symptom.conscience,
                          );
                        },
                      )
                    : Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      } else {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CupertinoNavigationBar(
            middle: Text("Histórico"),
          ),
          body: FutureBuilder<List>(
            future: PostgresDao().getSymptomsByBed(bedNumber),
            initialData: List(),
            builder: (context, snapshot) {
              if (snapshot.data.isEmpty) {
                return Center(child: Text("Sem dados salvos nesta cama"));
              } else {
                return snapshot.hasData
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, int position) {
                          final symptom = snapshot.data[position];
                          return SymptomsComponentList(
                            symptom.headache,
                            symptom.nausea,
                            symptom.tiredness,
                            symptom.diarrea,
                            symptom.pain,
                            symptom.others,
                            symptom.hourAndMinute,
                            symptom.formattedDate,
                            symptom.ox,
                            symptom.conscience,
                          );
                        },
                      )
                    : Center(child: CircularProgressIndicator());
              }
            },
          ),
        );
      }
    }
    // android
    else if (_platform == TargetPlatform.android) {
      if (isInpatient) {
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
            )
              ),
              body: FutureBuilder<List>(
                future: PostgresDao().getSymptomsByUser(
                    Provider.of<BedProvider>(contextProvider, listen: false)
                        .currentUserName),
                initialData: List(),
                builder: (context, snapshot) {
                  if (snapshot.data.isEmpty) {
                    return Center(
                        child: Text("Este paciente ainda não salvou sintomas"));
                  } else {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, int position) {
                              final symptom = snapshot.data[position];
                              return SymptomsComponentList(
                                symptom.headache,
                                symptom.nausea,
                                symptom.tiredness,
                                symptom.diarrea,
                                symptom.pain,
                                symptom.others,
                                symptom.hourAndMinute,
                                symptom.formattedDate,
                                symptom.ox,
                                symptom.conscience,
                              );
                            },
                          )
                        : Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ));
      } else {
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
              body: FutureBuilder<List>(
                future: PostgresDao().getSymptomsByBed(bedNumber),
                initialData: List(),
                builder: (context, snapshot) {
                  if (snapshot.data.isEmpty) {
                    return Center(child: Text("Sem dados salvos nesta cama"));
                  } else {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (_, int position) {
                              final symptom = snapshot.data[position];
                              return SymptomsComponentList(
                                symptom.headache,
                                symptom.nausea,
                                symptom.tiredness,
                                symptom.diarrea,
                                symptom.pain,
                                symptom.others,
                                symptom.hourAndMinute,
                                symptom.formattedDate,
                                symptom.ox,
                                symptom.conscience,
                              );
                            },
                          )
                        : Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ));
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
