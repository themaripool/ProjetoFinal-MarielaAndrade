import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BedDetails extends StatefulWidget {
  @override
  _BedDetailsState createState() => _BedDetailsState();
}

class _BedDetailsState extends State<BedDetails> {
  int segmentedControlGroupValue = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[700],
            title: Text("Colocar numero do leito aqui"),
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
              Text("Tela de dados aqui"),
              Text("Tela de alerta aqui")
            ],
          )),
    ));
  }
}
