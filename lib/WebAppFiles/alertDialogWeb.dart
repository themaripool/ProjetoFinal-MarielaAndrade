import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';
import 'package:projeto_final_1/WebAppFiles/detailsWeb.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';

var bedSeverityStatus;
var bedSeverityColor;
const TWO_PI = 3.14 * 2;

void checkInpatientStatus(String clinicalStatus) {
  if (clinicalStatus == "1") {
    bedSeverityStatus = "CRÍTICO";
    bedSeverityColor = Colors.red[700];
    return;
  } else if (clinicalStatus == "2") {
    bedSeverityStatus = "SEVERO";
    bedSeverityColor = Colors.yellow[700];
    return;
  } else if (clinicalStatus == "3") {
    bedSeverityStatus = "PREOCUPANTE";
    bedSeverityColor = Colors.blue[700];
    return;
  } else if (clinicalStatus == "4") {
    bedSeverityStatus = "ESTÁVEL";
    bedSeverityColor = Colors.green[700];
    return;
  }
}

class AlertDialogWeb extends StatelessWidget {
  final String bedId;
  final dynamic content;
  final String clinicalStatus;

  AlertDialogWeb(this.clinicalStatus, this.bedId, this.content);

  @override
  Widget build(BuildContext context) {
    checkInpatientStatus(clinicalStatus);
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: [
        Container(
          width: 210,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: bedSeverityColor,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AlertCloseButton(),
                AlertTitle(bedId: bedId),
                Image.asset('assets/images/warningIcon.png',
                    height: 60, width: 60),
                AlertInfoLabel(
                  content: content,
                ),
                AlertInfoDetails(
                  content: content,
                ),
                AlertButtons(
                  bedId: bedId,
                ),
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

class AlertTitle extends StatelessWidget {
  final String bedId;
  const AlertTitle({
    Key key,
    this.bedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Text("LEITO $bedId",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text("$bedSeverityStatus", style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}

class AlertButtons extends StatelessWidget {
  final String bedId;
  const AlertButtons({
    Key key,
    this.bedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey[900])),
              onPressed: () {
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPageWeb(bedId, -1),
                    ));
              },
              child: Text("VER DADOS", style: TextStyle(color: Colors.white))),
          OutlinedButton(
              style: ButtonStyle(
                side:
                    MaterialStateProperty.all(BorderSide(color: Colors.black)),
              ),
              onPressed: () {
                MQTTManagerWeb().send_alarm_recognition(bedId);
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
                        shape: BoxShape.circle, color: bedSeverityColor),
                  ),
                ),
                Center(
                  //centro do circulo
                  child: Container(
                    width: size - 40,
                    height: size - 40,
                    decoration: BoxDecoration(
                        color: bedSeverityColor, shape: BoxShape.circle),
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
