import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/API/BedDataList.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataScreen extends StatefulWidget {
  final List<BedDataDetails> bedInfo;

  const DataScreen({Key key, this.bedInfo}) : super(key: key);
  @override
  _DataScreenState createState() => _DataScreenState(this.bedInfo);
}

class _DataScreenState extends State<DataScreen> {
  List<BedDataDetails> bedInfo;
  List<bool> isChecked = List.generate(4, (index) => false);

  _DataScreenState(this.bedInfo);
  @override
  Widget build(BuildContext context) {
    //_createSampleData();
    return SingleChildScrollView(
      child: Column(
        children: [

          Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                  Image.asset('assets/images/respiratoryFreq.png',
                      height: 35, width: 35),
                  Checkbox(
                    value: isChecked[0],
                    onChanged: (val) {
                      setState(
                        () {
                          isChecked[0] = val;
                        },
                      );
                    },
                  ),
                  Text("Oxigênio: ${bedInfo.last.so} %")
                ],
              ),
            ),
            Visibility(
              visible: isChecked[0],
              child: cardWidgetSO(
                bedInfo: bedInfo
              ),
            )
          ],
        ),

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                  Image.asset('assets/images/temperature.png',
                      height: 35, width: 35),
                  Checkbox(
                    value: isChecked[1],
                    onChanged: (val) {
                      setState(
                        () {
                          isChecked[1] = val;
                        },
                      );
                    },
                  ),
                  Text("Temperatura: ${bedInfo.last.te} C")
                ],
              ),
            ),
            Visibility(
              visible: isChecked[1],
              child: cardWidgetTE(
                bedInfo: bedInfo
              ),
            )
          ],
        ),

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                  Image.asset('assets/images/pulse.png',
                      height: 35, width: 35),
                  Checkbox(
                    value: isChecked[2],
                    onChanged: (val) {
                      setState(
                        () {
                          isChecked[2] = val;
                        },
                      );
                    },
                  ),
                  Text("Pulso: ${bedInfo.last.fc} bpm")
                ],
              ),
            ),
            Visibility(
              visible: isChecked[2],
              child: cardWidgetFC(
                bedInfo: bedInfo
              ),
            )
          ],
        ),

        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
                  Image.asset('assets/images/respiratoryFreq.png',
                      height: 35, width: 35),
                  Checkbox(
                    value: isChecked[3],
                    onChanged: (val) {
                      setState(
                        () {
                          isChecked[3] = val;
                        },
                      );
                    },
                  ),
                  Text("Frequência respiratória: ${bedInfo.last.fr} pm")
                ],
              ),
            ),
            Visibility(
              visible: isChecked[3],
              child: cardWidgetFR(
                bedInfo: bedInfo
              ),
            )
          ],
        )

      ],),
    );
  }
}

class cardWidgetSO extends StatelessWidget {
  const cardWidgetSO({
    Key key,
    @required this.bedInfo,
  }) : super(key: key);

  final List<BedDataDetails> bedInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 350,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: SfCartesianChart(
              backgroundColor: Colors.transparent,
              margin: EdgeInsets.fromLTRB(24, 24, 24, 24),
              primaryXAxis: CategoryAxis(
                  autoScrollingMode: AutoScrollingMode.start,
                  labelPosition: ChartDataLabelPosition.outside,
                  tickPosition: TickPosition.inside),
              series: <ChartSeries>[
                StepLineSeries<BedDataDetails, String>(
                    dataSource: bedInfo,
                    xValueMapper: (BedDataDetails data, _) => data.dateDetails,
                    yValueMapper: (BedDataDetails data, _) => data.so)
              ]),
        ));
  }
}

class cardWidgetFR extends StatelessWidget {
  const cardWidgetFR({
    Key key,
    @required this.bedInfo,
  }) : super(key: key);

  final List<BedDataDetails> bedInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 350,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: SfCartesianChart(
              backgroundColor: Colors.transparent,
              margin: EdgeInsets.fromLTRB(24, 24, 24, 24),
              primaryXAxis: CategoryAxis(
                  autoScrollingMode: AutoScrollingMode.start,
                  labelPosition: ChartDataLabelPosition.outside,
                  tickPosition: TickPosition.inside),
              series: <ChartSeries>[
                StepLineSeries<BedDataDetails, String>(
                    dataSource: bedInfo,
                    xValueMapper: (BedDataDetails data, _) => data.dateDetails,
                    yValueMapper: (BedDataDetails data, _) => data.fr)
              ]),
        ));
  }
}

class cardWidgetTE extends StatelessWidget {
  const cardWidgetTE({
    Key key,
    @required this.bedInfo,
  }) : super(key: key);

  final List<BedDataDetails> bedInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 350,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: SfCartesianChart(
              backgroundColor: Colors.transparent,
              margin: EdgeInsets.fromLTRB(24, 24, 24, 24),
              primaryXAxis: CategoryAxis(
                  autoScrollingMode: AutoScrollingMode.start,
                  labelPosition: ChartDataLabelPosition.outside,
                  tickPosition: TickPosition.inside),
              series: <ChartSeries>[
                StepLineSeries<BedDataDetails, String>(
                    dataSource: bedInfo,
                    xValueMapper: (BedDataDetails data, _) => data.dateDetails,
                    yValueMapper: (BedDataDetails data, _) => data.te)
              ]),
        ));
  }
}

class cardWidgetFC extends StatelessWidget {
  const cardWidgetFC({
    Key key,
    @required this.bedInfo,
  }) : super(key: key);

  final List<BedDataDetails> bedInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 350,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: SfCartesianChart(
              backgroundColor: Colors.transparent,
              margin: EdgeInsets.fromLTRB(24, 24, 24, 24),
              primaryXAxis: CategoryAxis(
                  autoScrollingMode: AutoScrollingMode.start,
                  labelPosition: ChartDataLabelPosition.outside,
                  tickPosition: TickPosition.inside),
              series: <ChartSeries>[
                StepLineSeries<BedDataDetails, String>(
                    dataSource: bedInfo,
                    xValueMapper: (BedDataDetails data, _) => data.dateDetails,
                    yValueMapper: (BedDataDetails data, _) => data.fc)
              ]),
        ));
  }
}
