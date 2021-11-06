import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientViewModel.dart';

class SymptomsAlert extends StatelessWidget {
  var viewModel = InpatientViewModel();
  String caseString;
  SymptomsAlert(this.caseString);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 220,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text("Por favor, selecione o nível de desconforto", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 8,),
                  FormBuilderSegmentedControl(
                        selectedColor: Colors.grey[700],
                        borderColor: Colors.grey[700],
                        name: "headache",
                        options: List.generate(6, (i) => (i - 1) + 1)
                            .map((number) => FormBuilderFieldOption(value: number))
                            .toList(),
                        onChanged: (number) => {
                              if (caseString == "headache"){viewModel.setHeadache(context, number)},
                              if (caseString == "tiredness"){viewModel.setTiredness(context, number)},
                              if (caseString == "pain"){viewModel.setPain(context, number)},
                              if (caseString== "nausea"){viewModel.setNausea(context, number)},
                              if (caseString == "diarrhea"){viewModel.setDiarrhea(context, number)},
                              Navigator.pop(context)
                          }
                    ),
                  SizedBox(height: 8,),
                ],
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 60,
              child: Icon(Icons.report_problem_outlined, color: Colors.white, size: 50,),
            )
          ),
        ],
      )
    );
  }
}