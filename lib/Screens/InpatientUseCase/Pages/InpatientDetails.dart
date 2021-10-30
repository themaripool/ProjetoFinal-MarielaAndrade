import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class InpatientDetails extends StatefulWidget {
  String bedId;
  int index;

  InpatientDetails({Key key, this.bedId, this.index}) : super(key: key);

  @override
  _InpatientDetailsState createState() => _InpatientDetailsState(bedId, index);
}

class _InpatientDetailsState extends State<InpatientDetails> {
  _InpatientDetailsState(this.bedId, this.index);

  String bedId;
  int index;
  var title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      )),
      body: SingleChildScrollView(
        child: Consumer<BedProvider>(builder: (__, model, _) {
          List<BedData> graphInfo = List.from(model.holder[bedId]);

          switch (index) {
            case 0:
              title = "Frequencia Respiratoria";
              break;
            case 1:
              title = "Frequencia Cardiaca";
              break;
            case 2:
              title = "Temperatura";
              break;
            case 3:
              title = "Oxigênio";
              break;
          }

          return Column(
            children: [

              Text(title),

              Container(
                  height: 300,
                  width: 390,
                  child: Card(
                    elevation: 10,
                    color: Colors.grey[300],
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
                              yValueMapper: (BedData data, _) => index == 0 ? data.fr : index == 1 ? data.fc : index == 2 ? data.te : data.so ),
                        ]),
                  ))
            ],
          );
        }),
      ),
    );
  }
}
