/*
  InpatientRatingAlert: Alerta de classificação de dor do usuário
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Enums/Enums.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';

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
                  Consumer<Symptoms>(builder: (context, valor, child) {
                    return FormBuilderSegmentedControl(
                        selectedColor: Colors.grey[700],
                        borderColor: Colors.grey[700],
                        name: "headache",
                        options: List.generate(6, (i) => (i - 1) + 1)
                            .map((number) => FormBuilderFieldOption(value: number))
                            .toList(),
                        onChanged: (number) => {
                              print("sintoma = $caseString"),
                              print(
                                  "headache = ${InpatientSymptomsEnum.headache.toString()}"),
                              if (caseString == "headache")
                                {valor.setHeadacheVal(number)},
                              if (caseString == "tiredness")
                                {valor.setTirednessVal(number)},
                              if (caseString == "pain")
                                {valor.setPainVal(number)},
                              if (caseString== "nausea")
                                {valor.setNauseaVal(number)},
                              if (caseString == "diarrhea")
                                {valor.setDiarrheaVal(number)},
                              Navigator.pop(context)
                            });
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

// ignore: must_be_immutable
class OtherAlert extends StatelessWidget {
  var viewModel = InpatientViewModel();
  var controller = TextEditingController();
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
            height: 250,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text("Por favor, escreva o sintoma", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 16,),
                  TextField(
                    controller: controller,
                    textInputAction: TextInputAction.go,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'ex: tontura'),
                  ),
                  SizedBox(height: 16,),
                  RaisedButton(onPressed: () {
                    viewModel.setOther(context, controller.text);
                    Navigator.of(context).pop();
                  },
                    color: Colors.redAccent,
                    child: Text('Okay', style: TextStyle(color: Colors.white),),
                  )
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

// ignore: must_be_immutable
class ConscienceAlert extends StatelessWidget {
  var text;
  var viewModel = InpatientViewModel();
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
            height: 250,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text("Por favor, selecione o nível de consciência", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(onPressed: () {
                        text = 'Alerta';
                        viewModel.setConscienceLevel(context, text);
                        Navigator.of(context).pop();
                      },child: const Text('Alerta'),),
                      OutlinedButton(onPressed: () {
                        text = 'Confusão';
                        viewModel.setConscienceLevel(context, text);
                        Navigator.of(context).pop();
                      },child: const Text('Confusão'),),
                      OutlinedButton(onPressed: () {
                        text = 'Resposta Verbal';
                        viewModel.setConscienceLevel(context, text);
                        Navigator.of(context).pop();
                      },child: const Text('Resposta Verbal'),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(onPressed: () {
                        text = 'Resposta a Dor';
                        viewModel.setConscienceLevel(context, text);
                        Navigator.of(context).pop();
                      },child: const Text('Resposta a Dor'),),
                      OutlinedButton(onPressed: () {
                        text = 'Sem Resposta';
                        viewModel.setConscienceLevel(context, text);
                        Navigator.of(context).pop();
                      },child: const Text('Sem Resposta'),),
                    ],
                  ),
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

class OXAlert extends StatelessWidget {
  var text;
  var yes = false;
  var no = false;
  var viewModel = InpatientViewModel();
  var controller = TextEditingController();
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
            height: 250,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text("Por favor, indique a suplementação de oxigênio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(onPressed: () {
                        text = 'Sim';
                        viewModel.setOxLevel(context, text);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Sim'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          text = 'Não';
                          viewModel.setOxLevel(context, text);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Não'),
                        ),
                    ],
                  ),
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

