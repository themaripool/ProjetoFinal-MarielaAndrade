import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../MedicalTeamUseCase.dart';

class BedDetails extends StatefulWidget {
  final String bedId;
  final int initialIndex;
  BedDetails(this.bedId, this.initialIndex);

  @override
  _BedDetailsState createState() => _BedDetailsState(bedId, initialIndex);
}

class _BedDetailsState extends State<BedDetails> {
  final String bedId;
  final int initialIndex;

  _BedDetailsState(this.bedId, this.initialIndex);


  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text("Dados"),
    1: Text("Alertas"),
  };

  int theriGroupVakue = 0;

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;

    List<Widget> bodies = [
      DataScreen(
        bedId: widget.bedId,
      ),
      AlertScreen(
        bedNumber: widget.bedId,
        isAllAlarms: false,
      )
    ];

    if (_platform == TargetPlatform.iOS) {
      if (initialIndex != -1){
        theriGroupVakue = initialIndex;
      }
      return Scaffold(
        body: bodies[theriGroupVakue],
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Leito Número ${widget.bedId}",
            style: TextStyle(color: Colors.black),
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 45.0),
            child: Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: CupertinoSegmentedControl(
                      groupValue: theriGroupVakue,
                      onValueChanged: (changeFromGroupValue) {
                        setState(() {
                          theriGroupVakue = changeFromGroupValue;
                          print("bbbb $theriGroupVakue");
                        });
                      },
                      children: logoWidgets,
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return MaterialApp(
          home: DefaultTabController(
        length: 2,
        initialIndex: widget.initialIndex != -1 ? widget.initialIndex : 0,
        child: Scaffold(
            appBar: AppBar(
              leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
              backgroundColor: Colors.grey[700],
              title: Text("Leito Número ${widget.bedId}"),
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
                  bedId: widget.bedId,
                ),
                AlertScreen(
                  bedNumber: widget.bedId,
                  isAllAlarms: false,
                )
              ],
            )),
      ));
    }
  }
}
