import 'package:flutter/material.dart';
import 'package:projeto_final_1/API/mqttManager.dart';
import 'package:projeto_final_1/Components/HeaderDrawer.dart';
import 'package:projeto_final_1/Enums/DrawerSections.dart';
import 'package:projeto_final_1/Screens/DashBoard.dart';
import 'package:projeto_final_1/Screens/Settings.dart';

import 'Login.dart';
import 'Settings.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(primaryColor: Color.fromRGBO(236, 234, 234, 1.0)),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    var container;
    var title;

    if (currentPage == DrawerSections.dashboard) {
      container = Dashboard();
      title = Text("ENFERMARIA 1");
    } else if (currentPage == DrawerSections.settings) {
      container = Settings();
      title = Text("AJUSTES");
    }

    return Scaffold(
        appBar: AppBar(
          title: title,
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    MQTTManager().app_request_logout();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                  child: Icon(
                    Icons.logout,
                    size: 26.0,
                  ),
                ))
          ],
        ),
        body: container,
        drawer: Drawer(
            child: SingleChildScrollView(
                child: Container(
                    color: Colors.grey[700],
                    child: Column(children: [
                      HeaderDrawer(),

                      // inicio primeiro elemento menu

                      Container(
                          child: Column(children: [
                        Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                currentPage = DrawerSections.dashboard;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Icon(
                                      Icons.dashboard_outlined,
                                      size: 20,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "DashBoard",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ])),

                      //fim 1 elemento menu

                      //inicio 2 elemento menu
                      Container(
                          child: Column(children: [
                        Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                currentPage = DrawerSections.settings;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Icon(
                                      Icons.notifications,
                                      size: 20,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "Ajustes",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ])),

                      //fim 2 elemento menu
                    ])))));
  }
}
