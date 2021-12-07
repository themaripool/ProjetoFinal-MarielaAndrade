import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';

import 'pagesComponents/DetailsAlertsPageWeb.dart';

class AllAlarmsPageWeb extends StatelessWidget {
  String bedId;
  bool isAllAlarms;

  AllAlarmsPageWeb(this.bedId, this.isAllAlarms);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            bedId == '-1' ? "Todas as camas" : "Leito $bedId",
            style: TextStyle(color: Colors.white),
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
        body: DetailsAlertsPageWeb(bedId, isAllAlarms)
    );
  }
}