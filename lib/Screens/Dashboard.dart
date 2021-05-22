import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/BedDetails.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Tela de dashboard"),

          // ignore: deprecated_member_use
          RaisedButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BedDetails()),
            );
          })
        ],
      ),
    );
  }
}
