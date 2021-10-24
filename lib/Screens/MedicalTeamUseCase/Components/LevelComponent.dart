import 'package:flutter/material.dart';

var boxCount = 1;

checkSeverityBoxes(Color severitycolor) {
  if (severitycolor == Colors.blue) {
    boxCount = 2;
    return;
  } else if (severitycolor == Colors.yellow) {
    boxCount = 3;
    return;
  } else if (severitycolor == Colors.red) {
    boxCount = 4;
    return;
  } else if (severitycolor == Colors.green){
    boxCount = 1;
    return;
  }
}

class LevelComponentWidget extends StatelessWidget {
  final Color severitycolor;

  LevelComponentWidget(this.severitycolor);

  @override
  Widget build(BuildContext context) {
    checkSeverityBoxes(severitycolor);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white , width: 0.5 ),
              color: boxCount >= 1 ? severitycolor : Colors.grey[600]),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white , width: 0.5 ),
              color: boxCount >= 2 ? severitycolor : Colors.grey[600]),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white , width: 0.5 ),
              color: boxCount >= 3 ? severitycolor : Colors.grey[600]),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 0.5 ),
              color: boxCount == 4 ? severitycolor : Colors.grey[600]),
        ),
      ],
    );
  }
}
