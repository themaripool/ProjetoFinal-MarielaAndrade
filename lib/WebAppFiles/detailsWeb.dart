import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
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
              width: MediaQuery.of(context).size.width / 2,
              child: DataScreenWeb(
                bedId: bedId,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: DetailsAlertsPageWeb(bedId, false),
            )
          ],
        ));
  }
}

class DetailsAlertsPageWeb extends StatelessWidget {
  String bedId;
  bool allAlerts;
  DetailsAlertsPageWeb(this.bedId, this.allAlerts);
  @override
  Widget build(BuildContext context) {
    if(allAlerts == false){
      MQTTManagerWeb().makePGQuery('AlarmsByBed', bedId);
    } else{
      MQTTManagerWeb().makePGQuery('allAlarms', bedId);
    }
    
    return Consumer<BedProvider>(builder: (__, model, _) {
      if (model.allAlertsByBed.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
        return ListView.separated(
          itemCount: model.allAlertsByBed.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {},
                child: AlertComponentList(
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