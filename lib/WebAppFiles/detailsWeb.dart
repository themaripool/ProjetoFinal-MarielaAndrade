import 'package:flutter/material.dart';
import 'package:projeto_final_1/WebAppFiles/dataScreenWeb.dart';

class DetailsPageWeb extends StatelessWidget {
  String bedId;
  int initialIndex;

  DetailsPageWeb(this.bedId, this.initialIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Leito $bedId", style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.grey[350],
          
        ),
        body: DataScreenWeb( bedId: bedId,),
        );
  }
}
