import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/PatientSymptoms.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class _News2Data {
  _News2Data(this.pulse, this.time, this.temp);

  final double pulse;
  final String time;
  final double temp;
}

class PatientData extends StatefulWidget {
  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  List<_News2Data> data = [
    _News2Data(100.0, "17:55", 35.6),
    _News2Data(97.0, "18:05", 34.9),
    _News2Data(104.0, "18:15", 36.5),
    _News2Data(109.0, "18:28", 37.3),
    _News2Data(99.0, "18:55", 36.9)
  ];
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    final day = date.day;
    final month = date.month;
    final dayOfWeek = DateFormat('EEEE').format(date);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 32, left: 8),
            child: Text(
              "$dayOfWeek, $day / $month",
              style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 64),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PatientSymptoms()),
                    )
                  },
                  child: CardButtom(
                    icon: Icons.assignment_late_outlined,
                    text: "Sintomas do Dia",
                    width: 155,
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PatientSymptoms()),
                    )
                  },
                  child: CardButtom(
                    icon: Icons.event_note_outlined,
                    text: "Histórico de Sintomas",
                    width: 190,
                  ),
                ),
              ],
            ),
          ),
          SfCartesianChart(
              tooltipBehavior: TooltipBehavior(enable: true),
              primaryXAxis: CategoryAxis(),
              series: <CartesianSeries>[
                // Renders line chart
                SplineSeries<_News2Data, String>(
                    dataSource: data,
                    name: "Pulso",
                    enableTooltip: true,
                    xValueMapper: (_News2Data data, _) => data.time,
                    yValueMapper: (_News2Data data, _) => data.pulse,
                    markerSettings: MarkerSettings(isVisible: true)),

                SplineSeries<_News2Data, String>(
                    color: Colors.red,
                    dataSource: data,
                    name: "Temperatura",
                    enableTooltip: true,
                    xValueMapper: (_News2Data data, _) => data.time,
                    yValueMapper: (_News2Data data, _) => data.temp,
                    markerSettings: MarkerSettings(isVisible: true))
              ]),
        ],
      ),
    );
  }
}

class CardButtom extends StatelessWidget {
  const CardButtom({
    Key key,
    this.icon,
    this.text,
    this.width,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //event_note_outlined
              //Icons.assignment_late_outlined
              Text(text),
              Icon(this.icon)
            ],
          ),
        ),
      ),
    );
  }
}

class Alert2Widget extends StatelessWidget {
  const Alert2Widget({
    Key key,
  }) : super(key: key);

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
            color: Colors.pink,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album, size: 70),
                  title: Text('Heart Shaker',
                      style: TextStyle(color: Colors.white)),
                  subtitle:
                      Text('TWICE', style: TextStyle(color: Colors.white)),
                ),
                ButtonBarTheme(
                  data: ButtonBarThemeData(buttonHeight: 2),
                  child: ButtonBar(
                    children: <Widget>[
                      TextButton(
                        child: const Text('Ok',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
