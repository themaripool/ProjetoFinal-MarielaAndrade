import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/MedicalTeamPages/BedDetails.dart';
import 'package:projeto_final_1/Screens/MedicalTeamPages/Dashboard/Dashboard.dart';

class GridListView extends StatefulWidget {
  GridListView({Key key}) : super(key: key);

  @override
  _GridListViewState createState() => _GridListViewState();
}

class _GridListViewState extends State<GridListView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 2.0,
        childAspectRatio: (130 / 177),
        children: List.generate(componentes.length, (index) {
          return GestureDetector(
              onTap: () {
                print(index = index); //index comeca em 0 BedDetails()
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BedDetails(index + 1)),
                );
              },
              child: Center(child: componentes[index]));
        }));
  }
}