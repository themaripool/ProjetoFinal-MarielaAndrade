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

class _AlertDialogPatientState extends State<AlertDialogPatient> {
  final String bedId;
  final dynamic content;
  _AlertDialogPatientState(this.bedId, this.content);
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: [
        Container(
          width: 200,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Color.fromRGBO(230, 178, 47, 1.0),
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AlertCloseButton(),
                AlertTitle(),
                CircularGraph(
                  size: 100,
                ),
                AlertInfoLabel(content: content,),
                AlertInfoDetails(content: content,),
                AlertButtons(bedId: bedId,),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class AlertCloseButton extends StatelessWidget {
  const AlertCloseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(
            Icons.close,
          ),
          iconSize: 24,
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class AlertInfoDetails extends StatelessWidget {
  final dynamic content;
  const AlertInfoDetails({
    Key key, this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Text("FC: ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text("${content['SO']} bpm", style: TextStyle(fontSize: 14))
          ]),
          Row(children: [
            Text("Temp: ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text("${content['SO']} C", style: TextStyle(fontSize: 14))
          ]),
          Row(children: [
            Text("FR: ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text("${content['SO']} pm", style: TextStyle(fontSize: 14))
          ]),
        ],
      ),
    );
  }
}

class AlertInfoLabel extends StatelessWidget {
  final dynamic content;
  const AlertInfoLabel({
    Key key, this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment:
            CrossAxisAlignment.center, //Center Row contents vertically,
        children: [
          Text("SaO2",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("${content['SO']}%", style: TextStyle(fontSize: 18)),
          Icon(Icons.arrow_upward, size: 20)
        ],
      ),
    );
  }
}

class AlertTitle extends StatelessWidget {
  const AlertTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Text("LEITO 1",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text("Estado Severo", style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}

class AlertButtons extends StatelessWidget {

  final String bedId;
  const AlertButtons({
    Key key, this.bedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey[900])),
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
              },
              child: Text("VER DADOS", style: TextStyle(color: Colors.white))),
          OutlinedButton(
              style: ButtonStyle(
                side:
                    MaterialStateProperty.all(BorderSide(color: Colors.black)),
              ),
              onPressed: () {
                 MQTTManager().send_alarm_recognition(bedId);
                 Navigator.pop(context);
              },
              child: Row(
                children: [
                  Column(
                    children: [
                      Text("CONFERIR", style: TextStyle(color: Colors.black)),
                      Text("PACIENTE", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  Icon(
                    Icons.done,
                    color: Colors.black,
                    size: 24,
                  )
                ],
              ))
        ],
      ),
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