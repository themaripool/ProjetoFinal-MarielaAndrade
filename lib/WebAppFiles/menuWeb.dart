import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/WebAppFiles/detailsWeb.dart';
import 'package:projeto_final_1/WebAppFiles/loginWeb.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(context) => ListView(children: [
        FlatButton(
            onPressed: () {
              Provider.of<BedProvider>(context, listen: false)
                  .setSector("todos");
            },
            child: ListTile(
              title: Text("Todos Setores"),
            )),
        FlatButton(
            onPressed: () {
              Provider.of<BedProvider>(context, listen: false)
                  .setSector("setor 3");
            },
            child: ListTile(
              title: Text("Setor 3"),
            )),
        FlatButton(
            onPressed: () {
              Provider.of<BedProvider>(context, listen: false)
                  .setSector("setor 4");
            },
            child: ListTile(
              title: Text("Setor 4"),
            )),
        FlatButton(
            onPressed: () {
              Provider.of<BedProvider>(context, listen: false)
                  .setSector("setor 5");
            },
            child: ListTile(
              title: Text("Setor 5"),
            )),
        ListTile(
            title: Text(
              "Todos os alarmes da enfermaria",
            ),
            leading: Icon(
              Icons.all_inclusive,
              size: 20,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllAlarmsPageWeb('-1', true)),
              );
            }),
        ListTile(
            title: Text(
              "Sair",
            ),
            leading: Icon(
              Icons.exit_to_app,
              size: 20,
            ),
            onTap: () {
              MQTTManagerWeb().app_request_logout();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpApp()),
              );
            }),
      ]);
}

class AllAlarmsPageWeb extends StatelessWidget {
  String bedId;
  bool isAllAlarms;

  AllAlarmsPageWeb(this.bedId, this.isAllAlarms);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            bedId == '-1' ? "Todas as camas" : "Leito $bedId",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey[350],
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Provider.of<BedProvider>(context, listen: false)
                  .eraseAlertsListByBed();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: DetailsAlertsPageWeb(bedId, isAllAlarms)
    );
  }
}
