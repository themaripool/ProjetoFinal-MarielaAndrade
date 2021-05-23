import 'package:flutter/material.dart';

class LevelComponentWidget extends StatelessWidget {
  const LevelComponentWidget({
    Key key,
  }) : super(key: key);

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
              border: Border.all(color: Colors.black),
              color: Color.fromRGBO(230, 178, 47, 1.0)),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Color.fromRGBO(230, 178, 47, 1.0)),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Color.fromRGBO(230, 178, 47, 1.0)),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[350]),
              color: Colors.grey[350]),
        ),
      ],
    );
  }
}
