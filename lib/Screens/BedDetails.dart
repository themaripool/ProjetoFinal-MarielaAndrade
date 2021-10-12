import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/API/BedDataList.dart';
import 'package:projeto_final_1/Screens/AlertScreen.dart';
import 'package:projeto_final_1/Screens/DataScreen.dart';

class BedDetails extends StatelessWidget {
  final List<BedDataDetails> bedInfo;
  final String bedId;
  BedDetails(this.bedInfo, this.bedId);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.grey[700],
            title: Text("Leito Número $bedId"),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.data_usage),
                  text: "DADOS",
                ),
                Tab(
                  icon: Icon(Icons.notifications),
                  text: "ALERTAS",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              DataScreen(
                bedInfo: bedInfo,
              ),
              AlertScreen(
                bedNumber: bedId,
              )
            ],
          )),
    ));
  }
}
