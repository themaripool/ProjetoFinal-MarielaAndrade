import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Data/mqtt/mqttManager_web.dart';
import 'package:projeto_final_1/WEB/loginWeb.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(context) => ListView(children: [
        FlatButton(
            onPressed: () {
              Provider.of<BedProvider>(context, listen: false).setSector("todos");
            },
            child: ListTile(
              title: Text("Todos Setores"),
            )),
        FlatButton(
            onPressed: () {
              Provider.of<BedProvider>(context, listen: false).setSector("setor 3");
            },
            child: ListTile(
              title: Text("Setor 3"),
            )),
        FlatButton(
            onPressed: () {
              Provider.of<BedProvider>(context, listen: false).setSector("setor 4");
            },
            child: ListTile(
              title: Text("Setor 4"),
            )),
        FlatButton(
            onPressed: () {
              Provider.of<BedProvider>(context, listen: false).setSector("setor 5");
            },
            child: ListTile(
              title: Text("Setor 5"),
            )),
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
              Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpApp()),);
            }),
      ]);
}