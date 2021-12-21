import 'package:flutter/cupertino.dart';

/* ==================================================
  Componente de detalhes do alerta
===================================================== */

class AlertInfoDetails extends StatelessWidget {
  final dynamic content;
  const AlertInfoDetails({
    Key key,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(children: [
            Text("FC: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("${content['FC']} bpm", style: TextStyle(fontSize: 18))
          ]),
          Row(children: [
            Text("Temp: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("${content['TE']} C", style: TextStyle(fontSize: 18))
          ]),
        ],
      ),
    );
  }
}