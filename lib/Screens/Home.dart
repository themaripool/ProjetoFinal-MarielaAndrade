import 'package:flutter/material.dart';
import 'package:projeto_final_1/Components/HeaderDrawer.dart';
import 'package:projeto_final_1/Enums/DrawerSections.dart';
import 'package:projeto_final_1/Screens/MedicalTeamPages/Dashboard/Dashboard.dart';
import 'package:projeto_final_1/Screens/ThemeProvider.dart';
import 'package:provider/provider.dart';
import 'MedicalTeamPages/MenuPages/Settings.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      home: HomePage(),
      theme: themeNotifier.getTheme(),
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
        appBar: AppBar(title: title, centerTitle: true),
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
                                      size: 20
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "DashBoard",
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
                                      Icons.settings,
                                      size: 20,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "Ajustes",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]))

                      //fim 2 elemento menuItem
                    ])))));
  }
}

