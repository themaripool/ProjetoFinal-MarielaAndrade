import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../InpatientUseCase.dart';


// ignore: must_be_immutable
class InpatientDetails extends StatelessWidget {

  final int index;
  final String bedId;

  InpatientDetails(this.index, this.bedId);

  var title;
  var viewModel = InpatientViewModel();

  @override
  Widget build(BuildContext context) {
    title = viewModel.detailsTitle(index);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
          leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      )),
      body: SingleChildScrollView(
        child: Consumer<BedProvider>(builder: (__, model, _) {
          List<BedData> graphInfo = List.from(model.holder[bedId]);
          return Column(
            children: [
              InpatientGraph(graphInfo: graphInfo, index: index)
            ],
          );
        }),
      ),
    );
  }
}

class InpatientGraph extends StatelessWidget {
  const InpatientGraph({
    Key key,
    @required this.graphInfo,
    @required this.index,
  }) : super(key: key);

  final List<BedData> graphInfo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: 390,
        child: Card(
          elevation: 10,
          color: Colors.white,
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
                    xValueMapper: (BedData data, _) =>
                        data.dateDetails,
                    yValueMapper: (BedData data, _) => index == 0
                        ? data.fr
                        : index == 1
                            ? data.fc
                            : index == 2
                                ? data.te
                                : data.so),
              ]),
        ));
  }
}
