import 'package:flutter/material.dart';

class Symptoms extends ChangeNotifier {

  int headacheVal;
  int tirednessVal;
  int painVal;
  int nauseaVal;
  int diarrheaVal;
  String otherVal;

  Symptoms(this.headacheVal, this.tirednessVal, this.painVal, this.nauseaVal, this.diarrheaVal, this.otherVal);


  @override
  String toString() {
    return '$headacheVal';
  }
  void setHeadacheVal(int val){
    print("val recebido = $val");
    this.headacheVal = val;
    print("val do novo headache = ${this.headacheVal}");
    notifyListeners();
    print("passou aqui");
  }
 
  
}