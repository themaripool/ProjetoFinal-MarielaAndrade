import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';

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
            height: 300,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text("Por favor, selecione o nível de consciência", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),),
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(onPressed: () {
                        text = 'Resposta Verbal';
                        viewModel.setConscienceLevel(context, text);
                        Navigator.of(context).pop();
                      },child: const Text('Resposta Verbal'),),
                      OutlinedButton(onPressed: () {
                        text = 'Resposta a Dor';
                        viewModel.setConscienceLevel(context, text);
                        Navigator.of(context).pop();
                      },child: const Text('Resposta a Dor'),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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