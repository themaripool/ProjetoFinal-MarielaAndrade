import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientPage/InpatientHomeComponent.dart';

class _News2Data {
  _News2Data(this.pulse, this.time, this.temp, this.bloodPressure);

  final double pulse;
  final String time;
  final double temp;
  final int bloodPressure;
}

class PatientData extends StatefulWidget {
  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {

  var componentes = [
    InpatientHomeComponent(Colors.white, "Freq Res p/ min", "12"),
    InpatientHomeComponent(Colors.yellow, "PA", "92"),
    InpatientHomeComponent(Colors.orange, "Pulso", "111"),
    InpatientHomeComponent(Colors.white, "Consciencia", "Alerta"),
    InpatientHomeComponent(Colors.red, "Temperatura", "31.1 C"),
    InpatientHomeComponent(Colors.white, "SP 02", "88"),
  ];

  @override
  Widget build(BuildContext context) {

    return GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 2.0,
        childAspectRatio: (130 / 177),
        children: List.generate(componentes.length, (index) {
          return GestureDetector(
              onTap: () {},
              child: Center(child: componentes[index]));
        }));
  }
}

class CardButtom extends StatelessWidget {
  const CardButtom({
    Key key,
    this.icon,
    this.text,
    this.width,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: 80,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              Icon(this.icon)
            ],
          ),
        ),
      ),
    );
  }
}

class Alert2Widget extends StatelessWidget {
  const Alert2Widget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: [
        Container(
          width: 200,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.pink,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Icon(Icons.album, size: 70),
                  title: Text('Heart Shaker',
                      style: TextStyle(color: Colors.white)),
                  subtitle:
                      Text('TWICE', style: TextStyle(color: Colors.white)),
                ),
                ButtonBarTheme(
                  data: ButtonBarThemeData(buttonHeight: 2),
                  child: ButtonBar(
                    children: <Widget>[
                      TextButton(
                        child: const Text('Ok',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
