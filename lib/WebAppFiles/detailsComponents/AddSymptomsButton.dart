import 'package:flutter/material.dart';
import '../../Responsive.dart';
import 'AddSymptomsScreen.dart';

class AddSymptomsButton extends StatelessWidget {
  final numberBed;

  const AddSymptomsButton({this.numberBed});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * 1.5,
                  vertical: 16 / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new AddSymptomsScreen(numberBed: numberBed,);
                    },
                    fullscreenDialog: false));
              },
              icon: Icon(Icons.add), //botao add new
              label: Text(
                "Adicionar sintomas",
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }
}