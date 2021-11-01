import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/GeneralUseCase.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';

class HomePatient extends StatefulWidget {

  @override
  _HomePatientState createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  int _pageIndex = 0; 

  final List<Widget> _screens = [
    PatientData(),
    PatientSymptoms(),
    Settings()
  ];


  void onTabTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;

    if (_platform == TargetPlatform.iOS) {
      return MaterialApp(
        home: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Scaffold(
              appBar: CupertinoNavigationBar(
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/originals/c9/85/9c/c9859c3719f1328d1795df856940ddfd.jpg'),
                  radius: 18.0,
              ),
                ),
              middle: Text("Bem Vindo John Doe"),
        ),
        body: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.house), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.exclamationmark_circle_fill), label: 'Sintomas'),
                    BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.gear), label: 'Ajustes')
              ],
            ),
            tabBuilder: (BuildContext context, index) {
              _pageIndex = index;
              return _screens[index];
            }),
          )
        )
      );

    } else {

      return MaterialApp(
        home: DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            actions: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/c9/85/9c/c9859c3719f1328d1795df856940ddfd.jpg'),
                radius: 18.0,
              ),
            ],
            backgroundColor: Colors.grey[700],
            title: Text(
              "Bem Vindo John Doe",
              style: TextStyle(color: Colors.grey[350]),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _pageIndex, 
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.addchart_sharp), label: "Dados"),
            BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined), label: "Sintomas"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "Histórico"),
            ],
          ),
          body:  _screens[_pageIndex],
        ),
    ));

    }
  }
}
