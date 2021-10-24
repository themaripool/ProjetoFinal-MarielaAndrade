import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/Components/InpatientHomeComponent.dart';

import 'InpatientDetails.dart';

/* TELA DE HOME DO PACIENTE

- Possui cards com os dados do News2
- Cada card possui Icone, nome e dado observado
- Dado observado mudará de acordo com as mensagens recebidas do mqtt
- Dependendo da severidade, borda do card mudará
- Os cards sao clicaveis e irão para tela de detalhes da cada um dos dados do News2

TODO:
[] Após receber dados do back, fazer dados do card como observaveis
[x] Notifier do News2 criado
[] Ver como mudar cor de acordo com dados recebidos
*/

// ================== teste de tela ====================

class teste {
   String data;
   String valor;
   teste(this.data, this.valor);
 }

var lista = [
  teste("23:45", "23"), 
  teste("23:55", "24")
];
// ================== teste de tela ====================


class PatientData extends StatefulWidget {
  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {

  var componentes = [
    InpatientHomeComponent(Colors.grey, "Frequência Respiratória", "respiratoryFreq"),
    InpatientHomeComponent(Colors.yellow, "Pressão Arterial", "bloodPressure"),
    InpatientHomeComponent(Colors.orange, "Pulso", "pulse"),
    InpatientHomeComponent(Colors.grey, "Consciência", "conscience"),
    InpatientHomeComponent(Colors.red, "Temperatura", "temperature"),
    InpatientHomeComponent(Colors.grey, "SP 02", "sp"),
  ];

  @override
  Widget build(BuildContext context) {

    return GridView.count(
      padding: EdgeInsets.only(top: 16),
      crossAxisCount: 3,
      mainAxisSpacing: 20.0,
      crossAxisSpacing: 4.0,
      childAspectRatio: (130 / 177),
      children: List.generate(componentes.length, (index) {
        return GestureDetector(
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InpatientDetails(dataList: lista,)),
                );
            },
            child: Center(child: componentes[index]));
        }));
  }
}


