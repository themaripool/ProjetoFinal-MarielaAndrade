import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/Components/GraphComponent.dart';
import 'package:provider/provider.dart';

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
                  Text(
                      "Frequência respiratória: ${model.holder[bedId].last.fr} pm")
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
