import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
    _News2Data(97.0, "18:05", 34.9 ),
    _News2Data(104.0, "18:15", 36.5 ),
    _News2Data(109.0, "18:28", 37.3 ),
    _News2Data(99.0, "18:55", 36.9 )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
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
                markerSettings: MarkerSettings(isVisible: true)
            ),

            SplineSeries<_News2Data, String>(
              color: Colors.red,
              dataSource: data,
              name: "Temperatura",
              enableTooltip: true, 
              xValueMapper: (_News2Data data, _) => data.time,
              yValueMapper: (_News2Data data, _) => data.temp,
              markerSettings: MarkerSettings(isVisible: true)
            )

          ]),
        ],
      ),
    );
  }
}
