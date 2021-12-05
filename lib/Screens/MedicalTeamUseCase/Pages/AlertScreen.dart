import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import '../Components/AlertComponentList.dart';

class AlertScreen extends StatelessWidget {
  final String bedNumber;
  final bool isAllAlarms;

  const AlertScreen({Key key, this.bedNumber, this.isAllAlarms})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (isAllAlarms == false) {
      MQTTManager().makePGQuery('AlarmsByBed', bedNumber);
    } else {
      MQTTManager().makePGQuery('allAlarms', bedNumber);
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
