import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogPatient extends StatefulWidget {
  final Function(String password) onConfirm;

  AlertDialogPatient({@required this.onConfirm});

  @override
  _AlertDialogPatientState createState() => _AlertDialogPatientState();
}

const TWO_PI = 3.14 * 2;

class _AlertDialogPatientState extends State<AlertDialogPatient> {
//216 176 63
  @override
  Widget build(BuildContext context) {
    final size = 200.0;
    return AlertDialog(
      backgroundColor: Color.fromRGBO(230, 178, 47, 1.0),
      title: Center(child: Text("LEITO X", style: TextStyle(fontSize: 26))),
      content: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text(
                "Estado Severo",
                style: TextStyle(fontSize: 20),
              ),
            ),
            CircularGraph(size: size),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.center, //Center Row contents vertically,
                children: [
                  Text("SaO2",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  Text(" 79%", style: TextStyle(fontSize: 26)),
                  Icon(Icons.arrow_upward, size: 32)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Container(
                child: Column(
                  children: [
                    Row(children: [
                      Icon(Icons.arrow_downward, size: 20),
                      Text("FC: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("60 bpm", style: TextStyle(fontSize: 20))
                    ]),
                    Row(children: [
                      Text("Temp: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("36.1 C", style: TextStyle(fontSize: 20))
                    ]),
                    Row(children: [
                      Text("FR: ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text("12pm", style: TextStyle(fontSize: 20))
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              print("On pressed do cancelar");
              Navigator.pop(context);
            },
            child: Text("Cancelar")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Confirmar"))
      ],
    );
  }
}

class CircularGraph extends StatelessWidget {
  const CircularGraph({
    Key key,
    @required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(seconds: 4),
        builder: (context, value, child) {
          return Container(
            width: size,
            height: size,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return SweepGradient(
                            startAngle: 0.0,
                            endAngle: TWO_PI,
                            stops: [0.75, 0.75],
                            // 0.0 , 0.5 , 0.5 , 1.0
                            center: Alignment.center,
                            colors: [Colors.grey[900], Colors.grey[600]])
                        .createShader(rect);
                  },
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(216, 176, 63, 1.0)),
                  ),
                ),
                Center(
                  //centro do circulo
                  child: Container(
                    width: size - 40,
                    height: size - 40,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(216, 176, 63, 1.0),
                        shape: BoxShape.circle),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
