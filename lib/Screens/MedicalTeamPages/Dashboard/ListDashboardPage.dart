
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/MedicalTeamPages/BedDetails.dart';
import 'package:projeto_final_1/Screens/MedicalTeamPages/Dashboard/Dashboard.dart';

class ListViewPatients extends StatefulWidget {
  ListViewPatients({Key key}) : super(key: key);

  @override
  _ListViewPatientsState createState() => _ListViewPatientsState();
}

class _ListViewPatientsState extends State<ListViewPatients> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: componentesLista.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {
              print(index = index); //index comeca em 0 BedDetails()
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BedDetails(index + 1)),
              );
            },
            child: componentesLista[index]);
      },
    );
  }
}