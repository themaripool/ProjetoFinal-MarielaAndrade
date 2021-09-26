import 'package:flutter/material.dart';

class _AlertData {
  _AlertData(this.dataEMes, this.hora, this.dadosAlerta, this.cor);

  final String dataEMes;
  final String hora;
  final String dadosAlerta;
  final Color cor;
}

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  List<_AlertData> dadosAlerta = [
    _AlertData("01/05/2020", "8:30", "SaOs 79 %", Colors.orange[400].withOpacity(0.4)),
    _AlertData("01/05/2020", "7:30", "Temp 40 C", Colors.orange[400].withOpacity(0.4)),
    _AlertData("01/05/2020", "7:00", "SaOs 79 %", Colors.grey[300]),
    _AlertData("01/05/2020", "6:30", "SaOs 79 %", Colors.grey[300]),
    _AlertData("01/05/2020", "6:00", "SaOs 79 %", Colors.grey[300]),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: ListView.separated(
        itemCount: dadosAlerta.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.black,
        ),
        itemBuilder: (BuildContext context, int index) {
          return AlertComponentList(
              dadosAlerta[index].dataEMes,
              dadosAlerta[index].hora,
              dadosAlerta[index].dadosAlerta,
              dadosAlerta[index].cor);
        },
      ),
    );
  }
}

class AlertComponentList extends StatefulWidget {
  final String dataEMes;
  final String hora;
  final String dadosAlerta;
  final Color cor;

  AlertComponentList(this.dataEMes, this.hora, this.dadosAlerta, this.cor);

  @override
  _AlertComponentListState createState() => _AlertComponentListState(
      this.dataEMes, this.hora, this.dadosAlerta, this.cor);
}

class _AlertComponentListState extends State<AlertComponentList> {
  final String dataEMes;
  final String hora;
  final String dadosAlerta;
  final Color cor;

  _AlertComponentListState(
      this.dataEMes, this.hora, this.dadosAlerta, this.cor);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(color: cor),
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
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(Icons.arrow_upward, color: cor ==  Colors.orange[400].withOpacity(0.4) ? Colors.black : Colors.transparent ,),
              ),
              Text(dadosAlerta,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(Icons.done, color: cor ==  Colors.orange[400].withOpacity(0.4) ? Colors.white : Colors.black,),
              ),
            ],
          )),
    );
  }
}
