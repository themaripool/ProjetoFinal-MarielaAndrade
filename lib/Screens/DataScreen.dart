import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_final_1/API/BedDataList.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/* _getSeriesData(List<BedDataDetails> bedInfo) {
  /* List<charts.Series<BedDataDetails, int>> series = [
    charts.Series(
        id: "Sales",
        data: bedInfo,
        domainFn: (BedDataDetails series, _) => series.dateDetails, // eixo x
        measureFn: (BedDataDetails series, _) => series.fc, // eixo y
        colorFn: (BedDataDetails series, _) =>
            charts.MaterialPalette.blue.shadeDefault)
  ]; */

  /// List<charts.Series<BedDataDetails, DateTime>> series = [
  return [charts.Series<BedDataDetails, DateTime>(
    id: 'FC',
    colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
    domainFn: (BedDataDetails sales, _) => sales.dateDetails,
    measureFn: (BedDataDetails sales, _) => sales.fr,
    data: bedInfo,
  )];
  // ];
  //return series;
} */

var isDataVisible = false;
ChartSeriesController _chartSeriesController;

// ignore: missing_return
Void _updateDataSource(List<BedDataDetails> bedInfo) {
  print("============= tamanho ${bedInfo.length}=============");
  if (bedInfo.length == 15) {
    bedInfo.removeAt(0);
    _chartSeriesController?.updateDataSource(
        addedDataIndexes: <int>[bedInfo.length - 1],
        removedDataIndexes: <int>[0]);
  }
}

class DataScreen extends StatefulWidget {
  final List<BedDataDetails> bedInfo;
  DataScreen({Key key, this.bedInfo}) : super(key: key);

  @override
  _DataScreenState createState() => _DataScreenState(this.bedInfo);
}

class _DataScreenState extends State<DataScreen> {
  final List<BedDataDetails> bedInfo;

  bool _isCheckedSaOS = false;
  bool _isCheckedFC = false;
  bool _isCheckedTemp = false;
  bool _isCheckedFR = false;

  _DataScreenState(this.bedInfo);

  Widget build(BuildContext context) {
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
                Text("${bedInfo.last.so} %",
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
                Text("${bedInfo.last.fc} bpm",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
              ],
            ),
          ],
        ),

        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
              Text("${bedInfo.last.te} C",
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
              Text("${bedInfo.last.fr} pm",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
            ],
          ),
        ]),

        // Grafico

        /* Consumer<BedProvider>(builder: (__, model, _) {
          return Expanded(
            child: new charts.TimeSeriesChart(
              _getSeriesData(bedInfo),
              animate: true,
            ),
          );
        }), */

        /* Consumer<BedProvider>(
          builder: (__, model, _) {
            return Expanded(
                child: SfCartesianChart(
              series: <LineSeries<BedDataDetails, String>>[
                LineSeries<BedDataDetails, String>(
                  onRendererCreated: (ChartSeriesController controller) {
                    _chartSeriesController = controller;
                  },
                  // Binding the chartData to the dataSource of the line series.
                  dataSource: bedInfo,
                  xValueMapper: (BedDataDetails sales, _) => sales.dateDetails,
                  yValueMapper: (BedDataDetails sales, _) => sales.fr,
                )
              ],
            ));
          },
        ), */

        Consumer<BedProvider>(builder: (__, model, _) {
          _updateDataSource(bedInfo);
          return Expanded(
              child: SfCartesianChart(
                  onPointTapped: (PointTapArgs details) {
                    if (isDataVisible == true) {
                      isDataVisible = false;
                    } else {
                      isDataVisible = true;
                    }
                  },
                  primaryXAxis: CategoryAxis(
                      autoScrollingMode: AutoScrollingMode.start,
                      labelPosition: ChartDataLabelPosition.inside,
                      tickPosition: TickPosition.inside),
                  series: <ChartSeries>[
                // Renders line chart
                SplineSeries<BedDataDetails, String>(
                    onRendererCreated: (ChartSeriesController controller) {
                      _chartSeriesController = controller;
                    },
                    markerSettings: MarkerSettings(isVisible: true),
                    dataLabelSettings: DataLabelSettings(
                      isVisible: isDataVisible,
                    ),
                    dataSource: bedInfo,
                    xValueMapper: (BedDataDetails data, _) => data.dateDetails,
                    yValueMapper: (BedDataDetails data, _) => data.fr)
              ]));
        }),

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
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.done,
                    color: Colors.white,
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
