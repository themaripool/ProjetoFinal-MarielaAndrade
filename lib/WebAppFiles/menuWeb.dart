import 'package:flutter/material.dart';
import 'package:projeto_final_1/WebAppFiles/loginWeb.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(context) => ListView(children: [

        FlatButton(
            onPressed: () {
              print("modotv");
            },
            child: ListTile(
              title: Text("Modo TV"),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpWebApp()),
              );
            }),
      ]);
}
