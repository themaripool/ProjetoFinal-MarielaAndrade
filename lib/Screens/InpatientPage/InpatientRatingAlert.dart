import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:projeto_final_1/Enums/InpatientSymptomsEnum.dart';
import 'package:projeto_final_1/Screens/InpatientPage/Models/symptoms.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class InpatientRatingAlert extends StatefulWidget {
  final String symptomCase;

  InpatientRatingAlert(this.symptomCase);

  @override
  _InpatientRatingAlertState createState() => _InpatientRatingAlertState();
}

class _InpatientRatingAlertState extends State<InpatientRatingAlert> {

  _InpatientRatingAlertState();

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: [
        Container(
          width: 200,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.white70,
              elevation: 10,
              child: Column(
                children: [
                  Text("Por favor, selecione o nível de sua dor: "),
                  Consumer<Symptoms>(builder: (context, valor, child) {
                    return FormBuilderSegmentedControl(
                        selectedColor: Colors.grey[700],
                        borderColor: Colors.grey[700],
                        name: "headache",
                        options: List.generate(6, (i) => (i - 1) + 1)
                            .map((number) =>
                                FormBuilderFieldOption(value: number))
                            .toList(),
                        onChanged: (number) => {
                          print("sintoma = ${widget.symptomCase.toString()}"),
                          print("headache = ${InpatientSymptomsEnum.headache.toString()}"),
                              if (widget.symptomCase.toString() == "headache"){valor.setHeadacheVal(number)},
                              if (widget.symptomCase.toString() == "tiredness"){valor.setTirednessVal(number)},
                              if (widget.symptomCase.toString() == "pain"){valor.setPainVal(number)},
                              if (widget.symptomCase.toString() == "nausea"){valor.setNauseaVal(number)},
                              if (widget.symptomCase.toString() == "diarrhea"){valor.setDiarrheaVal(number)},
                              Navigator.pop(context)
                            });
                  })
                ],
              )),
        ),
      ],
    );
  }
}
