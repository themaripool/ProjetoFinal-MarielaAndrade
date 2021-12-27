import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';

/* ==================================================
  Lista de todos os sintomas da cama
===================================================== */

class AllSymptomsList extends StatelessWidget {
  String bedId;
  AllSymptomsList(this.bedId);

  @override
  Widget build(BuildContext context) {
    if (BedProvider().allSymptomByBed.isEmpty) {
      MQTTManagerWeb().makePGQuery('SymptomsByBed', bedId);
    }
    return Consumer<BedProvider>(builder: (__, model, _) {
      return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[350], //Color(0xFF292929),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Leito $bedId - Sintomas Salvos",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              dataRowHeight: 60,
              horizontalMargin: 0,
              columnSpacing: 10,
              columns: [
                DataColumn(
                  label: Text(" "),
                ),
              ],
              rows: List.generate(
                model.allSymptomByBed.length,
                (index) => symptomsRow(model.allSymptomByBed[index]),
              ),
            ),
          ),
        ],
      ),
    );
    });
  }
}

/* ==================================================
  Linhas do componente de todos os sintomas
===================================================== */

DataRow symptomsRow(Symptom res) {
  return DataRow(
    cells: [
      DataCell(Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Data: ${res.formattedDate}"),
                  Text("Consciência: ${res.conscience}"),
                  Text("Oxigênio: ${res.ox}"),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Cansaço: ${res.tiredness}"),
                  Text("Diarreia: ${res.diarrea}"),
                  Text("Dor: ${res.pain}")
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Outros: ${res.others}"),
                  Text("Cansaço: ${res.tiredness}"),
                  Text("Nausea: ${res.nausea}"),
                ],
              )
            ],
          ))),
    ],
  );
}