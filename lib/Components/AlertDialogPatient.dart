import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/API/BedDataList.dart';
import 'package:projeto_final_1/Components/LevelComponent.dart';
import 'package:projeto_final_1/API/mqttManager.dart';
import 'package:projeto_final_1/Screens/BedDetails.dart';
import 'package:provider/provider.dart';

class AlertDialogPatient extends StatefulWidget {
  final String bedId;
  final dynamic content;

  AlertDialogPatient(this.bedId, this.content);

  @override
  _AlertDialogPatientState createState() =>
      _AlertDialogPatientState(this.bedId, this.content);
}

const TWO_PI = 3.14 * 2;

//decoration: BoxDecoration(color: Color.fromRGBO(230, 178, 47, 1.0))

class _AlertDialogPatientState extends State<AlertDialogPatient> {
  final String bedId;
  final dynamic content;

  _AlertDialogPatientState(this.bedId, this.content);
//216 176 63
  @override
  Widget build(BuildContext context) {
    final size = 200.0;
    return Column(
      children: [
        Container(
          width: 300,
          height: 580,
          decoration: BoxDecoration(color: Color.fromRGBO(230, 178, 47, 1.0)),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 52),
                    child: Text("LEITO $bedId",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                  ),
                  Spacer(),
                  OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent)),
                      onPressed: () {
                        print("On pressed x");
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ))
                ],
              ),

              LevelComponentWidget(Colors.yellow),

              Padding(
                padding: const EdgeInsets.only(bottom: 32, top: 8),
                child: Text("Estado Severo", style: TextStyle(fontSize: 20)),
              ),

              CircularGraph(size: size),

              //texto abaixo do circulo
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment
                      .center, //Center Row contents vertically,
                  children: [
                    Text("SaO2",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                    Text(" ${content['SO']}", style: TextStyle(fontSize: 26)),
                    Icon(Icons.arrow_upward, size: 32)
                  ],
                ),
              ),

              Padding(
                  padding: const EdgeInsets.only(top: 32.0, left: 16),
                  child: Container(
                    child: Column(
                      children: [
                        Row(children: [
                          Icon(Icons.arrow_downward, size: 20),
                          Text("FC: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("${content['FC']} bpm",
                              style: TextStyle(fontSize: 20))
                        ]),
                        Row(children: [
                          Text("Temp: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("${content['TE']} C",
                              style: TextStyle(fontSize: 20))
                        ]),
                        Row(children: [
                          Text("FR: ",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("${content['FR']} pm",
                              style: TextStyle(fontSize: 20))
                        ]),
                      ],
                    ),
                  )),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.grey[900])),
                        onPressed: () {
                          print("------ bed id $bedId -------");
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BedDetails(
                                    Provider.of<BedProvider>(context,
                                            listen: false)
                                        .bedDataListHistoryBed4,
                                    bedId)),
                          );
                          ;
                        },
                        child: Text("VER DADOS",
                            style: TextStyle(color: Colors.white))),
                    Spacer(),
                    OutlinedButton(
                        style: ButtonStyle(
                          side: MaterialStateProperty.all(
                              BorderSide(color: Colors.black)),
                        ),
                        onPressed: () {
                          MQTTManager().send_alarm_recognition(bedId);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text("CONFERIR",
                                    style: TextStyle(color: Colors.black)),
                                Text("PACIENTE",
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                            Icon(
                              Icons.done,
                              color: Colors.black,
                              size: 32,
                            )
                          ],
                        )),
                  ],
                ),
              )
            ],
          ),
        )
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
