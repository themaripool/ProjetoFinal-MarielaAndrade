import 'package:flutter/material.dart';
import 'package:projeto_final_1/WebAppFiles/alertComponents.dart/AlertComponents.dart';
import 'package:projeto_final_1/WebAppFiles/dataScreenWeb.dart';
import 'package:projeto_final_1/WebAppFiles/detailsComponents/DetailsComponents.dart';

class DetailsPageWeb extends StatelessWidget {
  String bedId;
  int initialIndex;
  DetailsPageWeb(this.bedId, this.initialIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: Text("SmartAlarmsWeb"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              AddSymptomsButton(numberBed: bedId,), 
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        DataScreenWeb(
                          bedId: bedId,
                        ), 
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SizedBox(height: 80),
                        AllAlertsList(bedId),
                        SizedBox(height: 16),
                        AllSymptomsList(bedId)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}