import 'package:flutter/material.dart';

class AlertComponentList extends StatelessWidget {
  final String dataEMes;
  final String hora;
  final String bedId;
  final String clinicalStatus;
  AlertComponentList(this.dataEMes, this.hora, this.clinicalStatus, this.bedId);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(dataEMes,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(hora,
                    style: TextStyle(fontSize: 14, color: Colors.black)),
              ),
              Spacer(),
              Text("Cama $bedId",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.arrow_upward,
                  color: Colors
                      .black, //cor == Colors.orange[400].withOpacity(0.4) ? Colors.black : Colors.transparent,
                ),
              ),
              Text(clinicalStatus,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.done,
                  color: Colors
                      .black, //cor == Colors.orange[400].withOpacity(0.4) ? Colors.white : Colors.black,
                ),
              ),
            ],
          )),
    );
  }
}
