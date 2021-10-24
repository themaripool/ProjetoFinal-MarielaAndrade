import 'package:flutter/material.dart';

class HeaderDrawer extends StatefulWidget {
  @override
  _HeaderDrawerState createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.grey[700],
        width: double.infinity,
        height: 200,
        padding: EdgeInsets.only(top: 20.0),
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/originals/c9/85/9c/c9859c3719f1328d1795df856940ddfd.jpg'),
              radius: 30.0,
            ),
          ),
          Align(
            alignment: Alignment.centerRight - Alignment(1.0, 0.1),
            child: Text(
              'John Doe',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          Align(
            alignment: Alignment.centerRight - Alignment(1.15, -0.3),
            child: Text(
              'Médico',
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        ]));
  }
}
