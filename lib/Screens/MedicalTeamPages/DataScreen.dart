import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataScreen extends StatefulWidget {
  DataScreen({Key key}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<_PatientData> data = [
    _PatientData(79, 60, 36.1, 12, "11"),
    _PatientData(80, 50, 35.8, 13, "12"),
    _PatientData(30, 20, 32.8, 20, "13"),
    _PatientData(100, 70, 20.8, 13, "14"),
    _PatientData(80, 10, 35.8, 13, "15")
  ];

  bool _isCheckedSaOS = false;
  bool _isCheckedFC = false;
  bool _isCheckedTemp = false;
  bool _isCheckedFR = false;

  Widget build(BuildContext context) {
    print("Carregou com valor de saos $_isCheckedSaOS e fc $_isCheckedFC");
    print("Data ${data[0].fr} ");
    return Expanded(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Checkbox(
                  value: _isCheckedSaOS,
                  onChanged: (value) {
                    setState(() {
                      _isCheckedSaOS = !_isCheckedSaOS;
                      print(
                          "SaOS com valor de $_isCheckedSaOS com value$value");
                    });
                  },
                ),
                Text("SaOS: ", style: TextStyle(fontSize: 18)),
                Text("${data[0].saOS} %",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _isCheckedFC,
                  onChanged: (value) {
                    setState(() {
                      _isCheckedFC = !_isCheckedFC;
                      print("FC com valor de $_isCheckedFC com value $value");
                    });
                  },
                ),
                Text("FC: ", style: TextStyle(fontSize: 18)),
                Text("${data[0].fc} bpm",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              ],
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Row(
            children: [
              Checkbox(
                value: _isCheckedTemp,
                onChanged: (value) {
                  setState(() {
                    _isCheckedTemp = !_isCheckedTemp;
                  });
                },
              ),
              Text("Temp: ", style: TextStyle(fontSize: 18)),
              Text("${data[0].temp} C",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: _isCheckedFR,
                onChanged: (value) {
                  setState(() {
                    _isCheckedFR = !_isCheckedFR;
                  });
                },
              ),
              Text("FR: ", style: TextStyle(fontSize: 18)),
              Text("${data[0].fr} pm",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
            ],
          ),
        ]),

        // Grafico

        //       List<_PatientData> data = [
        //   _PatientData(79, 60, 36.1, 12, "11"),
        //   _PatientData(80, 50, 35.8, 13, "12"),
        //   _PatientData(30, 20, 32.8, 20, "13"),
        //   _PatientData(100, 70, 20.8, 13, "14"),
        //   _PatientData(80, 10, 35.8, 13, "15")
        // ];

        //  final double saOS;
        // final double fc;
        // final double temp;
        // final double fr;
        // final String hour;

        SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <ChartSeries<_PatientData, String>>[
              //SaOS
              SplineAreaSeries<_PatientData, String>(
                  dataSource: data,
                  isVisible: false,
                  xValueMapper: (_PatientData dados, _) => dados.hour,
                  yValueMapper: (_PatientData dados, _) => dados.saOS,
                  color: Colors.yellow.withAlpha(150)),
              //FC
              SplineAreaSeries<_PatientData, String>(
                  dataSource: data.sublist(1),
                  isVisible: _isCheckedFC == false ? false : true,
                  xValueMapper: (_PatientData dados, _) => dados.hour,
                  yValueMapper: (_PatientData dados, _) => dados.fc,
                  color: Colors.pink.withAlpha(100)),
              // //Temp
              // SplineAreaSeries<_PatientData, String>(
              //     dataSource: data.sublist(2),
              //     xValueMapper: (_PatientData sales, _) => sales.hour,
              //     yValueMapper: (_PatientData sales, _) => sales.temp,
              //     name: 'Temp',
              //     dataLabelSettings: DataLabelSettings(isVisible: false),
              //     color: Colors.yellow[500]
              // ),
              // //Fr
              // SplineAreaSeries<_PatientData, String>(
              //     dataSource: data.sublist(3),
              //     xValueMapper: (_PatientData sales, _) => sales.hour,
              //     yValueMapper: (_PatientData sales, _) => sales.Fr
              //     name: 'Fr',
              //     dataLabelSettings: DataLabelSettings(isVisible: true),
              //     color: Colors.yellow[700]
              // )
            ]),

        OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.grey[850],
            ),
            onPressed: () {
              print("Clicou no conferir paciente");
            },
            child: Container(
              height: 35,
              width: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Conferir Paciente',
                  ),
                  Icon(
                    Icons.done
                  )
                ],
              ),
            ))
      ]),
    );
  }
}

class _PatientData {
  _PatientData(this.saOS, this.fc, this.temp, this.fr, this.hour);

  final double saOS;
  final double fc;
  final double temp;
  final double fr;
  final String hour;
}
