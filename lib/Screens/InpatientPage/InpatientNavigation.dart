import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientPage/Home/InpatientData.dart';
import 'package:projeto_final_1/Screens/InpatientPage/Symptoms/InpatientSymptoms.dart';

class HomePatient extends StatefulWidget {

  @override
  _HomePatientState createState() => _HomePatientState();
}

class _HomePatientState extends State<HomePatient> {
  
  int _pageIndex = 0; 

  final List<Widget> _screens = [
    PatientData(),
    PatientSymptoms()
  ];

  void onTabTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
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
                  icon: Icon(Icons.addchart_sharp), label: "DADOS"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.analytics_outlined),
                  label: "SINTOMAS"),
            ],
          ),
          body:  _screens[_pageIndex],
        ),
    ));
  }
}
