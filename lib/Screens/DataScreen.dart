import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_final_1/API/BedDataList.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataScreen extends StatefulWidget {
  final String bedId;

  const DataScreen({Key key, this.bedId}) : super(key: key);
  @override
  _DataScreenState createState() => _DataScreenState(this.bedId);
}

class _DataScreenState extends State<DataScreen> {
  String bedId;
  List<bool> isChecked = List.generate(4, (index) => false);

  _DataScreenState(this.bedId);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<BedProvider>(builder: (__, model, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
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
                  Text("Oxigênio: ${model.holder[bedId].last.so} %")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
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
                  Text("Temperatura: ${model.holder[bedId].last.te} C")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
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
                  Text("Pulso: ${model.holder[bedId].last.fc} bpm")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Row(
                children: [
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
                  Text("Frequência respiratória: ${model.holder[bedId].last.fr} pm")
                ],
              ),
            ),
            cardWidgetGeneral(
              bedInfo: model.holder[bedId],
              isChecked: isChecked,
            ),
          ],
        );
      }),
    );
  }
}

class cardWidgetGeneral extends StatelessWidget {
  const cardWidgetGeneral({
    Key key,
    @required this.bedInfo,
    this.isChecked,
  }) : super(key: key);

  final LinkedList<BedDataDetails> bedInfo;
  final List<bool> isChecked;

  @override
  Widget build(BuildContext context) {
    List<BedDataDetails> graphInfo = List.from(bedInfo);

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
                    dataSource: graphInfo,
                    xValueMapper: (BedDataDetails data, _) => data.dateDetails,
                    yValueMapper: (BedDataDetails data, _) =>
                        isChecked[0] == true ? data.so : null),
                StepLineSeries<BedDataDetails, String>(
                    dataSource: graphInfo,
                    xValueMapper: (BedDataDetails data, _) => data.dateDetails,
                    yValueMapper: (BedDataDetails data, _) =>
                        isChecked[1] == true ? data.te : null),
                StepLineSeries<BedDataDetails, String>(
                    dataSource: graphInfo,
                    xValueMapper: (BedDataDetails data, _) => data.dateDetails,
                    yValueMapper: (BedDataDetails data, _) =>
                        isChecked[2] == true ? data.fc : null),
                StepLineSeries<BedDataDetails, String>(
                    dataSource: graphInfo,
                    xValueMapper: (BedDataDetails data, _) => data.dateDetails,
                    yValueMapper: (BedDataDetails data, _) =>
                        isChecked[3] == true ? data.fr : null)
              ]),
        ));
  }
}
