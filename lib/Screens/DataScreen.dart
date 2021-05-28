import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataScreen extends StatefulWidget {
  DataScreen({Key key}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {

   List<_PatientData> data = [
    _PatientData(79, 10, 36.1, 12, "11"),
    _PatientData(80, 50, 35.8, 13, "12"),
    _PatientData(30, 20, 32.8, 20, "13"),
    _PatientData(100, 70, 20.8, 13, "14"),
    _PatientData(80, 10, 35.8, 13, "15")
  ];
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: [
            //Initialize the chart widget
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                legend: Legend(isVisible: false),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_PatientData, String>>[
                  //SaOS
                  SplineAreaSeries<_PatientData, String>(
                      dataSource: data.sublist(0),
                      xValueMapper: (_PatientData sales, _) => sales.hour,
                      yValueMapper: (_PatientData sales, _) => sales.saOS,
                      name: 'SaOS',
                      dataLabelSettings: DataLabelSettings(isVisible: false),
                      color: Colors.yellow.withAlpha(150)
                  ),
                  //FC
                  SplineAreaSeries<_PatientData, String>(
                      dataSource: data.sublist(1),
                      xValueMapper: (_PatientData sales, _) => sales.hour,
                      yValueMapper: (_PatientData sales, _) => sales.fc,
                      name: 'Fc',
                      dataLabelSettings: DataLabelSettings(isVisible: false),
                      color: Colors.pink.withAlpha(100)
                  ),
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
                ]
                
                
                ),
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
