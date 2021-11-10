import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/GeneralUseCase.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/config.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';
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
      if (initialIndex != -1) {
        theriGroupVakue = initialIndex;
      }
      return Scaffold(
        body: bodies[theriGroupVakue],
        appBar: AppBar(
          leading: CupertinoNavigationBarBackButton(
            color: CupertinoColors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NavigationSymptoms(widget.bedId);
                    }));
                  },
                  child: Icon(
                    CupertinoIcons.add,
                    size: 26.0,
                  ),
                ))
          ],
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
                      borderColor: Colors.black,
                      selectedColor: Colors.grey[850],
                      groupValue: theriGroupVakue,
                      onValueChanged: (changeFromGroupValue) {
                        setState(() {
                          theriGroupVakue = changeFromGroupValue;
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
          theme: SwitchProvider.lightTheme,
          darkTheme: SwitchProvider.darkTheme,
          themeMode: currentTheme.currentTheme,
          home: DefaultTabController(
            length: 2,
            initialIndex: widget.initialIndex != -1 ? widget.initialIndex : 0,
            child: Scaffold(
                appBar: AppBar(
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  actions: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NavigationSymptoms(widget.bedId);
                            }));
                          },
                          child: Icon(
                            Icons.add,
                            size: 26.0,
                          ),
                        ))
                  ],
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

class NavigationSymptoms extends StatelessWidget {
  String numberBed;
  NavigationSymptoms(this.numberBed);
  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    if (_platform == TargetPlatform.iOS) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Sintomas do paciente"),
        ),
        body: PatientSymptoms(
          numberBed: numberBed,
          isInpatient: false,
        ),
      );
    } else {
      return Scaffold(
            appBar: AppBar(
              title: Text("Sintomas do paciente"),
              centerTitle: true,
            ),
            body: PatientSymptoms(numberBed: numberBed, isInpatient: false),
          );
    }
  }
}
