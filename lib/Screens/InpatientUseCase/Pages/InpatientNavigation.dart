/*
  HomePatient: TELA DE NAVEGAÇÃO
  - Define a navigation bar de acordo com o sistema que está sendo usado
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/GeneralUseCase.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/config.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';

class HomePatient extends StatefulWidget {

  @override
  _HomePatientState createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  int _pageIndex = 0; 

  final List<Widget> _screens = [
    PatientData(),
    PatientSymptoms(isInpatient: true,),
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
        theme: SwitchProvider.lightTheme,
      darkTheme: SwitchProvider.darkTheme,
      themeMode: currentTheme.currentTheme,
        home: DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Scaffold(
              appBar: CupertinoNavigationBar(
              middle: _pageIndex == 0 ? Text("Dados") : _pageIndex == 1 ? Text("Sintomas") : Text("Ajustes"),
        ),
        body: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.house), label: 'Dados'),
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
      theme: SwitchProvider.lightTheme,
      darkTheme: SwitchProvider.darkTheme,
      themeMode: currentTheme.currentTheme,
        home: DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[700],
            title: _pageIndex == 0 ? Text("Home") : _pageIndex == 1 ? Text("Sintomas") : Text("Ajustes")
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
                icon: Icon(Icons.settings), label: "Ajustes"),
            ],
          ),
          body:  _screens[_pageIndex],
        ),
    ));

    }
  }
}
