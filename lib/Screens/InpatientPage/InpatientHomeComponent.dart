import 'package:flutter/material.dart';

class InpatientHomeComponent extends StatefulWidget {
  final Color severitycolor;
  final String title;
  final String description;

  InpatientHomeComponent(this.severitycolor, this.title, this.description);

  @override
  _InpatientHomeComponentState createState() => _InpatientHomeComponentState(
      this.severitycolor, this.title, this.description);
}

class _InpatientHomeComponentState extends State<InpatientHomeComponent> {
  final Color severitycolor;
  final String title;
  final String description;

  _InpatientHomeComponentState(
      this.severitycolor, this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      width: 130.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200], width: 4),
          color: severitycolor,
          borderRadius: new BorderRadius.all(Radius.circular(15))
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(description,
                style: TextStyle(fontSize: 18, color: Colors.black)),
          )
        ],
      ),
    );
  }
}
