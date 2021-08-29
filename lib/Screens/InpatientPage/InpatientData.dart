import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientPage/InpatientHomeComponent.dart';

class PatientData extends StatefulWidget {
  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {

  var componentes = [
    InpatientHomeComponent(Colors.white, "Frequência Respiratória", "12 p/ min", "respiratoryFreq"),
    InpatientHomeComponent(Colors.yellow, "Pressão Arterial", "92", "bloodPressure"),
    InpatientHomeComponent(Colors.orange, "Pulso", "111", "pulse"),
    InpatientHomeComponent(Colors.white, "Consciência", "Alerta", "conscience"),
    InpatientHomeComponent(Colors.red, "Temperatura", "31.1 C", "temperature"),
    InpatientHomeComponent(Colors.white, "SP 02", "88", "sp"),
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
