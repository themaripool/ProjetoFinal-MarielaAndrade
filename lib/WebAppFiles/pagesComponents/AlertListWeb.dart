import 'package:flutter/material.dart';

class AlertListWeb extends StatelessWidget {
  final String dataEMes;
  final String hora;
  final String bedId;
  final String clinicalStatus;
  AlertListWeb(this.dataEMes, this.hora, this.clinicalStatus, this.bedId);

  String checkClinicalStatus(String status) {
    if (status == '0') {
      return 'Estável';
    } else if (status == '1') {
      return 'Preocupante';
    } else if (status == '2') {
      return 'Severo';
    } else {
      return 'Crítico';
    }
  }

  String status;

  @override
  Widget build(BuildContext context) {
    status = checkClinicalStatus(clinicalStatus);
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(232, 245, 249, 1),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade700, blurRadius: 5)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 40,
                          child: SizedBox(
                              child: Icon(Icons.warning_amber_rounded)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$dataEMes',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '$hora',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Estado Clínico: $status',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Leito: $bedId',
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}