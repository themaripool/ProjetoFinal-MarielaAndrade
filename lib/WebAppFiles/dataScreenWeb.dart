import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DataScreenWeb extends StatefulWidget {
  final String bedId;

  const DataScreenWeb({Key key, this.bedId}) : super(key: key);
  @override
  _DataScreenWebState createState() => _DataScreenWebState(this.bedId);
}

class _DataScreenWebState extends State<DataScreenWeb> {
  String bedId;
  List<bool> isChecked = List.generate(4, (index) => false);
  
  _DataScreenWebState(this.bedId);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<BedProvider>(builder: (__, model, _) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        Text(
                            "Frequência respiratória: ${model.holder[bedId].last.fr} pm")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: cardWidgetWeb(
                    bedInfo: model.holder[bedId],
                    isChecked: isChecked,
                  ),
            ),
          ],
        );
      }),
    );
  }
}