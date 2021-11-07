import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../GeneralUseCase.dart';
import 'Dashboard/Dashboard.dart';
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
  var _currentTab = 0;

  List<Widget> _tabs = [
      Dashboard(), // see the HomeTab class below
      Settings() // see the SettingsTab class below
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    if (_platform == TargetPlatform.iOS) {
      return Scaffold(
        appBar: CupertinoNavigationBar(
          middle: _currentTab == 0 ? Text("Enfermaria") : Text("Ajustes"),
        ),
        body: CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              onTap: (index) {
                setState(() {
                  _currentTab = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home), label: 'Dashboard'),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings), label: 'Ajustes')
              ],
            ),
            tabBuilder: (BuildContext context, index) {
              return _tabs[index];
            }),
      );
    } else {
      return MaterialApp(
        home: DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
          appBar: AppBar(
            title: _currentTab == 0 ? Text("Enfermaria") : Text("Ajustes") ,
            centerTitle: true,
            backgroundColor: Colors.grey[700],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentTab, 
            onTap: onTabTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Ajustes"),
            ],
          ),
          body:  _tabs[_currentTab],
        ),
    ));
    }
  }
}
