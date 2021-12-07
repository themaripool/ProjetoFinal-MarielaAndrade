import 'package:flutter/material.dart';

class AlertInfoLabel extends StatelessWidget {
  final dynamic content;
  const AlertInfoLabel({
    Key key,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment:
            CrossAxisAlignment.center, //Center Row contents vertically,
        children: [
          Row(children: [
            Text("SaO2: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("${content['SO']}%", style: TextStyle(fontSize: 18)),
          ]),
          Row(children: [
            Text("FR: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("${content['FR']} pm", style: TextStyle(fontSize: 18))
          ]),
        ],
      ),
    );
  }
}