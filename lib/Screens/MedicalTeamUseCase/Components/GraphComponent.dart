
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class cardWidgetGeneral extends StatelessWidget {
  const cardWidgetGeneral({
    Key key,
    @required this.bedInfo,
    this.isChecked,
  }) : super(key: key);

  final LinkedList<BedData> bedInfo;
  final List<bool> isChecked;

  @override
  Widget build(BuildContext context) {
    List<BedData> graphInfo = List.from(bedInfo);

    return Container(
        height: 300,
        width: 390,
        child: Card(
          elevation: 10,
          child: SfCartesianChart(
              backgroundColor: Colors.transparent,
              margin: EdgeInsets.fromLTRB(24, 24, 24, 24),
              primaryXAxis: CategoryAxis(
                  autoScrollingMode: AutoScrollingMode.start,
                  labelPosition: ChartDataLabelPosition.outside,
                  tickPosition: TickPosition.inside),
              series: <ChartSeries>[
                StepLineSeries<BedData, String>(
                    dataSource: graphInfo,
                    xValueMapper: (BedData data, _) => data.dateDetails,
                    yValueMapper: (BedData data, _) =>
                        isChecked[0] == true ? data.so : null),
                StepLineSeries<BedData, String>(
                    dataSource: graphInfo,
                    xValueMapper: (BedData data, _) => data.dateDetails,
                    yValueMapper: (BedData data, _) =>
                        isChecked[1] == true ? data.te : null),
                StepLineSeries<BedData, String>(
                    dataSource: graphInfo,
                    xValueMapper: (BedData data, _) => data.dateDetails,
                    yValueMapper: (BedData data, _) =>
                        isChecked[2] == true ? data.fc : null),
                StepLineSeries<BedData, String>(
                    dataSource: graphInfo,
                    xValueMapper: (BedData data, _) => data.dateDetails,
                    yValueMapper: (BedData data, _) =>
                        isChecked[3] == true ? data.fr : null)
              ]),
        ));
  }
}