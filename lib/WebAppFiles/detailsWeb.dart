import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';
import 'package:projeto_final_1/WebAppFiles/dataScreenWeb.dart';
import 'package:projeto_final_1/WebAppFiles/pagesComponents/NavigationWebSymptoms.dart';

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
            return NavigationWebSymptoms(bedId);
          }));
        },
        child: Icon(Icons.mouse),
        backgroundColor: Colors.green,
      ),
    );
  }
}
