import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Enums/Enums.dart';

import '../GeneralUseCase.dart';
import 'Dashboard.dart';
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
    final _platform = Theme.of(context).platform;
    var _currentTab = 0;

    var container;
    var title;

    List<Widget> _tabs = [
      Dashboard(), // see the HomeTab class below
      Settings() // see the SettingsTab class below
    ];

    if (currentPage == DrawerSections.dashboard) {
      container = Dashboard();
      title = Text("ENFERMARIA 1");
    } else if (currentPage == DrawerSections.settings) {
      container = Settings();
      title = Text("AJUSTES");
    }

    if (_platform == TargetPlatform.iOS) {
      return Scaffold(
        appBar: CupertinoNavigationBar(
            middle: _currentTab == 0 ? Text("ENFERMARIA 1") : Text("AJUSTES"),
        ),
        body: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings')
              ],
            ),
            tabBuilder: (BuildContext context, index) {
              _currentTab = index;
              return _tabs[index];
            }),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: title,
            centerTitle: true,
            backgroundColor: Colors.grey[700],
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

                        Container(
                            child: Column(children: [
                          Material(
                            child: InkWell(
                              onTap: () {
                              Navigator.pop(context);
                              MQTTManager().app_request_logout();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Icon(
                                        Icons.exit_to_app,
                                        size: 20,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Sair",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ])),
                        //fim 3 elemento menu
                      ])))));
    }
  }
}
