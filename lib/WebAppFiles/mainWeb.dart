import 'package:flutter/material.dart';
import 'package:projeto_final_1/WebAppFiles/MainPageContent.dart';
import 'package:projeto_final_1/WebAppFiles/menuWeb.dart';

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
                        child: MainPageContent(
                          axisCount: 2,
                        ))
                    : MediaQuery.of(context).size.width > 800 &&
                            MediaQuery.of(context).size.width <= 1004
                        ? Row(children: [
                            Container(width: 200.0, child: Menu()),
                            Container(
                                width:
                                    MediaQuery.of(context).size.width - 200.0,
                                child: MainPageContent(
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
                                    child: MainPageContent(
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
                                        child: MainPageContent(
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
                                            child: MainPageContent(
                                              axisCount: 6,
                                            )),
                                      ])
                                    : MediaQuery.of(context).size.width < 400
                                        ? Container(
                                            width: 200,
                                            child: MainPageContent(
                                              axisCount: 1,
                                            ))
                                        : Container(
                                            width: 200,
                                            child: MainPageContent(
                                              axisCount: 1,
                                            )))));
  }
}