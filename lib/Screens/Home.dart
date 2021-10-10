import 'package:flutter/material.dart';
import 'package:projeto_final_1/API/mqttManager.dart';
import 'package:projeto_final_1/Components/HeaderDrawer.dart';
import 'package:projeto_final_1/Enums/DrawerSections.dart';
import 'package:projeto_final_1/Screens/DashBoard.dart';
import 'package:projeto_final_1/Screens/Search.dart';
import 'package:projeto_final_1/Screens/Settings.dart';

import 'Login.dart';
import 'Notifications.dart';
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
    } else if (currentPage == DrawerSections.notifications) {
      container = Notifications();
      title = Text("NOTIFICAÇÕES");
    } else if (currentPage == DrawerSections.settings) {
      container = Settings();
      title = Text("AJUSTES");
    } else if (currentPage == DrawerSections.search) {
      container = Search();
      title = Text("BUSCAR");
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
                                currentPage = DrawerSections.notifications;
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
                                      "Notificações",
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

                      //inicio 3 elemento menu
                      Container(
                          child: Column(children: [
                        Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                currentPage = DrawerSections.search;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Icon(
                                      Icons.search,
                                      size: 20,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      "Buscar",
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

                      //inicio 4 elemento menu
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
                      ]))

                      //fim 4 elemento menu
                    ])))));
  }
}

// // ignore: non_constant_identifier_names
// Widget DrawerMenu(BuildContext context, DrawerSections currentPage) {
//     return Container(
//       padding: EdgeInsets.only(
//         top: 15,
//       ),
//       child: Column(
//                children: [
//           menuItem(1, "Dashboard", Icons.dashboard_outlined,
//               currentPage == DrawerSections.dashboard ? true : false, context, currentPage),
//           menuItem(2, "Notificações", Icons.notification_important,
//               currentPage == DrawerSections.notifications ? true : false, context, currentPage),
//           menuItem(3, "Ajustes", Icons.settings,
//               currentPage == DrawerSections.settings ? true : false, context, currentPage),
//           menuItem(4, "Search", Icons.search,
//               currentPage == DrawerSections.search ? true : false, context, currentPage),
//                ]),
//     );
//   }

//   Widget menuItem(int id, String title, IconData icon, bool selected, BuildContext context, DrawerSections currentPage) {
//     return Material(
//       color: selected ? Colors.grey[300] : Colors.transparent,
//       child: InkWell(
//         onTap: () {
//           Navigator.pop(context);
//           setState(() {
//             if (id == 1) {
//               currentPage = DrawerSections.dashboard;
//             } else if (id == 2) {
//               currentPage = DrawerSections.notifications;
//             } else if (id == 3) {
//               currentPage = DrawerSections.settings;
//             } else if (id == 4) {
//               currentPage = DrawerSections.search;
//             }
//           });
//         },
//         child: Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Icon(
//                   icon,
//                   size: 20,
//                   color: Colors.grey[700],
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     color: Colors.white70
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
