import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projeto_final_1/Screens/MedicalTeamPages/Dashboard/Components/AlertDialogPatient.dart';
import 'package:projeto_final_1/Screens/MedicalTeamPages/Dashboard/Components/BedComponent.dart';
import 'package:projeto_final_1/Screens/MedicalTeamPages/Dashboard/Components/BedComponentList.dart';
import 'package:projeto_final_1/Screens/MedicalTeamPages/Dashboard/GridDashboardPage.dart';
import 'package:projeto_final_1/Screens/MedicalTeamPages/Dashboard/ListDashboardPage.dart';

var componentes = [
  BedComponent(
      "LEITO 1", Colors.yellow, Color.fromRGBO(230, 178, 47, 1.0), "SEVERO"),
  BedComponent("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
  BedComponent("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
];

var componentesLista = [
  BedComponentList(
      "LEITO 1", Colors.yellow, Color.fromRGBO(230, 178, 47, 1.0), "SEVERO"),
  BedComponentList("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
  BedComponentList("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
];

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var status = true;
  var container;

  @override
  Widget build(BuildContext context) {
    if (status == true) {
      container = GridListView();
    } else if (status == false) {
      container = ListViewPatients();
    }

    return Scaffold(
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AlertDashboardButton(),
                  Spacer(),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: status == true
                              ? Colors.grey[850]
                              : Colors.transparent,
                          side: BorderSide(
                            width: 1.5,
                            color: Colors.black,
                          )),
                      onPressed: () {
                        setState(() {
                          status = true;
                          print(status);
                        });
                      },
                      child: Icon(
                        Icons.grid_on,
                        color: status == false ? Theme.of(context).primaryColorDark : Theme.of(context).primaryColorLight,
                      )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: status == false
                              ? Colors.grey[850]
                              : Colors.transparent,
                          side: BorderSide(
                            width: 1.5,
                            color: Colors.black,
                          )),
                      onPressed: () {
                        setState(() {
                          status = false;
                          print(status);
                        });
                      },
                      child: Icon(
                        Icons.list,
                        color: status == false ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColorDark,
                      )),
                ],
              ),
            ),
            Expanded(child: Center(child: container)),
          ]),
        ));
  }
}

class AlertDashboardButton extends StatelessWidget {
  const AlertDashboardButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            side: BorderSide(
          width: 1.5,
          color: Theme.of(context).primaryColor,
        )),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialogPatient();
            },
          );
        },
        child: const Text(
          'Alarmes',
        ));
  }
}




