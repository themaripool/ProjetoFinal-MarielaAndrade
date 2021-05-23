import 'package:flutter/material.dart';

class LevelComponentWidget extends StatelessWidget {
  final Color severitycolor;

  LevelComponentWidget(this.severitycolor);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black), color: severitycolor),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black), color: severitycolor),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black), color: severitycolor),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black), color: Colors.grey[350]),
        ),
      ],
    );
  }
}
