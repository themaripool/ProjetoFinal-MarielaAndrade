/*
  InpatientHomeComponent: Card da home do páciente com os dados observados
*/

import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import '../InpatientUseCase.dart';

// ignore: must_be_immutable
class InpatientHomeComponent extends StatelessWidget {
  final int index;
  final String bedId;

  InpatientHomeComponent(this.index, this.bedId);

  var icon;
  var title;
  var displayData;
  var color;

  var viewModel = InpatientViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<BedProvider>(builder: (__, model, _) {
      color = viewModel.checkInpatient(model.holder[bedId].last, index);
      title = viewModel.setTitle(index);
      icon = viewModel.setIcon(index);
      displayData = viewModel.setDisplayData(model, bedId, index);

      return Container(
          height: 160.0,
          width: 130.0,
          decoration: BoxDecoration(
              border: Border.all(color: color, width: 4),
              color: Colors.grey[850],
              borderRadius: new BorderRadius.all(Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Padding(
                  padding: const EdgeInsets.all(8), child: Text(displayData, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              )
            ],
          ));
    });
  }
}
