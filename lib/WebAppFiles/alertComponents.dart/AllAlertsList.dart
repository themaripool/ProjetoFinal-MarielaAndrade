

import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';

/* ==================================================
  Lista de todos os alertas da cama
===================================================== */

class AllAlertsList extends StatelessWidget {
  String bedId;
  AllAlertsList(this.bedId);

  @override
  Widget build(BuildContext context) {
    if (BedProvider().allAlertsByBed.isEmpty) {
      MQTTManagerWeb().makePGQuery('AlarmsByBed', bedId);
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
            "Leito $bedId - Todos os Alertas",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              horizontalMargin: 0,
              columnSpacing: 10,
              columns: [
                DataColumn(
                  label: Text(" "),
                ),
              ],
              rows: List.generate(
                model.allAlertsByBed.take(10).length,
                (index) => alertsRow(model.allAlertsByBed[index]),
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
  Linhas do componente de todos os alertas
===================================================== */

DataRow alertsRow(Alert res) {
  return DataRow(
    cells: [
      DataCell(Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Row(
            children: [
              Text("Data: ${res.dateAndMonth}"),
              Spacer(),
              Text("CS: ${res.clinicalStatus}"),
              Spacer(),
              Text("Hora: ${res.hourAndMinute}"),
              Spacer(),
              Text("Cama: ${res.bedId}")
            ],
          ))),
    ],
  );
}