import 'package:flutter/material.dart';
import 'package:projeto_final_1/Components/BedComponent.dart';

class Dashboard extends StatelessWidget {
  var componentes = [
    BedComponent("LEITO 1", Colors.yellow),
    BedComponent("LEITO 2", Colors.blue),
    BedComponent("LEITO 3", Colors.green),
    BedComponent("LEITO 4", Colors.red),
    BedComponent("LEITO 1", Colors.yellow),
    BedComponent("LEITO 2", Colors.blue),
    BedComponent("LEITO 3", Colors.green),
    BedComponent("LEITO 4", Colors.red),
    BedComponent("LEITO 1", Colors.yellow),
    BedComponent("LEITO 2", Colors.blue),
    BedComponent("LEITO 3", Colors.green),
    BedComponent("LEITO 4", Colors.red),
    BedComponent("LEITO 1", Colors.yellow),
    BedComponent("LEITO 2", Colors.blue),
    BedComponent("LEITO 3", Colors.green),
    BedComponent("LEITO 4", Colors.red)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: (130 / 177),
            children: List.generate(componentes.length, (index) {
              return Center(child: componentes[index]);
            })));
  }
}
