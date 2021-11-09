/* InpatientSymptomsHistory: TELA DE HISTÓRICO DE SINTOMAS DO PACIENTE
- Mostra histórico de sintomas de acordo com o so
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';

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
        appBar: CupertinoNavigationBar(
          middle: Text("Histórico"),
        ),
        body: FutureBuilder<List>(
          future: PostgresDao().getSymptomsByBed(bedNumber),
          initialData: List(),
          builder: (context, snapshot) {
            if (snapshot.data.isEmpty){
              return Center(child: Text("Sem dados"));
            }else {
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
        appBar: AppBar(
          title: Text("Histórico"),
          backgroundColor: Colors.grey[700],
        ),
        body: FutureBuilder<List>(
          future: PostgresDao().getSymptomsByBed(bedNumber),
          initialData: List(),
          builder: (context, snapshot) {
            if (snapshot.data.isEmpty){
              return Center(child: Text("Sem dados salvos nesta cama"));
            }else {
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
          padding: const EdgeInsets.all(16.0),
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
