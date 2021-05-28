import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/DataScreen.dart';

class BedDetails extends StatefulWidget {
  final int bedNumber;
  BedDetails(this.bedNumber);
  @override
  _BedDetailsState createState() => _BedDetailsState(this.bedNumber);
}

class _BedDetailsState extends State<BedDetails> {
  int segmentedControlGroupValue = 0;
  final int bedNumber;

 _BedDetailsState(this.bedNumber);
  

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
            title: Text("Leito Número $bedNumber"),
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
              DataScreen(),
              Text("Tela de alerta aqui")
            ],
          )),
    ));
  }
}
