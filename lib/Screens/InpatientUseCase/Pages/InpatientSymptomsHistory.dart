/* InpatientSymptomsHistory: TELA DE HISTÓRICO DE SINTOMAS DO PACIENTE
- Mostra histórico de sintomas de acordo com o so
*/

import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';

class InpatientSymptomsHistory extends StatelessWidget {
  final String bedNumber;
  final bool isAllAlarms;

  const InpatientSymptomsHistory({Key key, this.bedNumber, this.isAllAlarms})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    if (_platform == TargetPlatform.iOS) {
      return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CupertinoNavigationBar(middle: Text("Histórico"),),
      body: FirebaseAnimatedList(
        query: SymptomsDao().getAllSymptoms(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final symptom = Symptom.fromJson(json);
          return SymptomsComponentList(
              symptom.headache,
              symptom.nausea,
              symptom.tiredness,
              symptom.diarrea,
              symptom.pain,
              symptom.others,
              symptom.hourAndMinute);
        },
      ),
    );
    } else {
      return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Histórico"), backgroundColor: Colors.grey[700],),
      body: FirebaseAnimatedList(
        query: SymptomsDao().getAllSymptoms(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final symptom = Symptom.fromJson(json);
          return SymptomsComponentList(
              symptom.headache,
              symptom.nausea,
              symptom.tiredness,
              symptom.diarrea,
              symptom.pain,
              symptom.others,
              symptom.hourAndMinute);
        },
      ),
    );

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
  SymptomsComponentList(this.headache, this.nausea, this.tiredness,
      this.diarrea, this.pain, this.others, this.hourAndMinute);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.0,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(children: [
                Text(hourAndMinute,
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Dor de Cabeça: $headache",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  Text("Nausea: $nausea",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Cansaço $tiredness",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  Text("Diarreia: $diarrea",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Dor: $pain",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                  Text("Outros: $others",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ],
              )
            ],
          )),
    );
  }
}
