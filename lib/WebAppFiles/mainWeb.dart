import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/BedModel.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';
import 'package:projeto_final_1/WebAppFiles/detailsWeb.dart';
import 'package:projeto_final_1/WebAppFiles/menuWeb.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';

class MyAppWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePageWeb(),
    );
  }
}

class HomePageWeb extends StatefulWidget {
  @override
  _HomePageWebState createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[350],
          title: Text("SmartAlarmsWeb"),
          actions: [
            GestureDetector(
              onTap: () {
                MQTTManagerWeb().makePGQuery('SymptomsByUser');
              },
              child: Icon(
                Icons.search,
                size: 26.0,
              ),
            )
          ],
        ),
        drawer: MediaQuery.of(context).size.width < 800
            ? Drawer(
                child: Menu(),
              )
            : null,
        body: SafeArea(
            child: Center(
                child: MediaQuery.of(context).size.width < 800 &&
                        MediaQuery.of(context).size.width > 500
                    ? Container(
                        width: 400,
                        child: Content(
                          axisCount: 2,
                        ))
                    : MediaQuery.of(context).size.width > 800 &&
                            MediaQuery.of(context).size.width <= 1004
                        ? Row(children: [
                            Container(width: 200.0, child: Menu()),
                            Container(
                                width:
                                    MediaQuery.of(context).size.width - 200.0,
                                child: Content(
                                  axisCount: 3,
                                )),
                          ])
                        : MediaQuery.of(context).size.width > 1004 &&
                                MediaQuery.of(context).size.width <= 1300
                            ? Row(children: [
                                Container(width: 200.0, child: Menu()),
                                Container(
                                    width: MediaQuery.of(context).size.width -
                                        200.0,
                                    child: Content(
                                      axisCount: 4,
                                    )),
                              ])
                            : MediaQuery.of(context).size.width > 1300 &&
                                    MediaQuery.of(context).size.width <= 1500
                                ? Row(children: [
                                    Container(width: 200.0, child: Menu()),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                200.0,
                                        child: Content(
                                          axisCount: 5,
                                        )),
                                  ])
                                : MediaQuery.of(context).size.width > 1500
                                    ? Row(children: [
                                        Container(width: 200.0, child: Menu()),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                200.0,
                                            child: Content(
                                              axisCount: 6,
                                            )),
                                      ])
                                    : MediaQuery.of(context).size.width < 400
                                        ? Container(
                                            width: 200,
                                            child: Content(
                                              axisCount: 1,
                                            ))
                                        : Container(
                                            width: 200,
                                            child: Content(
                                              axisCount: 1,
                                            )))));
  }
}

class Content extends StatelessWidget {
  final axisCount;
  Content({this.axisCount});

  var mock = BedData(
      bedNumber: 1,
      dateDetails: "12/12/2021",
      fc: 98,
      fr: 60,
      sector: "3",
      so: 2,
      te: 32.1);

  @override
  Widget build(BuildContext context) {
    if (Provider.of<BedProvider>(context, listen: false).selectedSector ==
        null) {
      Provider.of<BedProvider>(context, listen: false).setSector("todos");
    }
    return Consumer<BedProvider>(
      builder: (__, model, _) {
        if (model.holder.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.count(
              crossAxisCount: axisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              childAspectRatio: (140 / 140),
              children: List.generate(
                  model.bySector[model.selectedSector].length, (index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPageWeb(
                                model.bySector[model.selectedSector][index]
                                    .bedNumber
                                    .toString(),
                                -1)),
                      );
                    },
                    child: BedComponent(
                      bedInfo: model.bySector[model.selectedSector][index],
                    ));
              }));
        }
      },
    );
  }
}
