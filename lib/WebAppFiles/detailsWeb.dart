import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/AlertModel.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/Components/AlertComponentList.dart';
import 'package:projeto_final_1/WebAppFiles/dataScreenWeb.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';

class DetailsPageWeb extends StatelessWidget {
  String bedId;
  int initialIndex;

  DetailsPageWeb(this.bedId, this.initialIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Leito $bedId",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.grey[350],
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Provider.of<BedProvider>(context, listen: false)
                  .eraseAlertsListByBed();
              Navigator.of(context).pop();
            },
          ),
          
        ),
        body: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: DataScreenWeb(
                bedId: bedId,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              child: DetailsAlertsPageWeb(bedId, false),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                MaterialPageRoute(builder: (contextNavigation) {
              return NavigationWebSymptoms("7");
            }));
        },
        child: Icon(Icons.mouse),
        backgroundColor: Colors.green,
      ),);
  }
}

class NavigationWebSymptoms extends StatelessWidget {
  String numberBed;
  NavigationWebSymptoms(this.numberBed);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sintomas do paciente"),
        centerTitle: true,
      ),
      body: PatientSymptoms(numberBed: numberBed, isInpatient: false),
    );
  }
}



class DetailsAlertsPageWeb extends StatelessWidget {
  String bedId;
  bool allAlerts;
  /* var mock = [
    Alert("1", "1", "1", "1", "12/12", "18:49", false),
    Alert("0", "1", "1", "1", "13/12", "12:49", false),
    Alert("2", "1", "1", "1", "13/12", "15:49", false),
    Alert("3", "1", "1", "1", "13/12", "19:49", false),
  ]; */
  DetailsAlertsPageWeb(this.bedId, this.allAlerts);
  @override
  Widget build(BuildContext context) {
    if (allAlerts == false) {
       MQTTManagerWeb().makePGQuery('AlarmsByBed', bedId);
    } else {
      MQTTManagerWeb().makePGQuery('allAlarms', bedId);
    }

    return Consumer<BedProvider>(builder: (__, model, _) {
      if (model.allAlertsByBed.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
      return ListView.builder(
        itemCount: model.allAlertsByBed.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
              child: AlertListWeb(
                model.allAlertsByBed[index].dateAndMonth,
                model.allAlertsByBed[index].hourAndMinute,
                model.allAlertsByBed[index].clinicalStatus,
                model.allAlertsByBed[index].bedId,
              ));
        },
      );
    }
    });
  }
}

class AlertListWeb extends StatelessWidget {
  final String dataEMes;
  final String hora;
  final String bedId;
  final String clinicalStatus;
  AlertListWeb(this.dataEMes, this.hora, this.clinicalStatus, this.bedId);

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

  String status;

  @override
  Widget build(BuildContext context) {
    status = checkClinicalStatus(clinicalStatus);
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(232, 245, 249, 1),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade700, blurRadius: 5)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 40,
                          child: SizedBox(
                              child: Icon(Icons.warning_amber_rounded)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$dataEMes',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$hora',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Estado Clínico: $status',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Leito: $bedId',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

/*************************************************************** */
