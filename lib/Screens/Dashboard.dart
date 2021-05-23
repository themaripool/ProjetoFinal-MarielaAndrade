import 'package:flutter/material.dart';
import 'package:projeto_final_1/Components/BedComponent.dart';

class Dashboard extends StatelessWidget {
  var componentes = [
    BedComponent(
        "LEITO 1", Colors.yellow, Color.fromRGBO(230, 178, 47, 1.0), "SEVERO"),
    BedComponent("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
    BedComponent("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
    BedComponent("LEITO 4", Colors.red, Colors.red, "CRÍTICO"),
    BedComponent("LEITO 1", Colors.yellow, Colors.yellow, "SEVERO"),
    BedComponent("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
    BedComponent("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
    BedComponent("LEITO 4", Colors.red, Colors.red, "CRÍTICO"),
    BedComponent("LEITO 1", Colors.yellow, Colors.yellow, "SEVERO"),
    BedComponent("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
    BedComponent("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
    BedComponent("LEITO 4", Colors.red, Colors.red, "CRÍTICO"),
    BedComponent("LEITO 1", Colors.yellow, Colors.yellow, "SEVERO"),
    BedComponent("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
    BedComponent("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
    BedComponent("LEITO 4", Colors.red, Colors.red, "CRÍTICO")
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
