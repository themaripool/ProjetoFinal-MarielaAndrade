import 'package:flutter/material.dart';
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
    InpatientSymptomsHistory()
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
