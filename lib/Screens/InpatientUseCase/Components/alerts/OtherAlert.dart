import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';

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