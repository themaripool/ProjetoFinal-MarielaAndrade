import 'package:flutter/material.dart';

class Symptoms extends ChangeNotifier {

  int headacheVal;
  int tirednessVal;
  int painVal;
  int nauseaVal;
  int diarrheaVal;
  String otherVal;

  Symptoms(this.headacheVal, this.tirednessVal, this.painVal, this.nauseaVal, this.diarrheaVal, this.otherVal);

// Formatacao do int para String na exibicao no app
  
  String toStringHeadache(){
    return '$headacheVal';
  }

  String toStringTiredness(){
    return '$tirednessVal';
  }

  String toStringPain(){
    return '$painVal';
  }

  String toStringNausea(){
    return '$nauseaVal';
  }

  String toStringDiarrhea(){
    return '$diarrheaVal';
  }

  String toStringOthers(){
    return '$otherVal';
  }

  // Atualizacoes dos dados usando provider

  void setHeadacheVal(int val){
    this.headacheVal = val;
    notifyListeners();
    print("notificaou");
  }

   void setTirednessVal(int val){
    this.tirednessVal = val;
    notifyListeners();
  }

   void setPainVal(int val){
    this.painVal = val;
    notifyListeners();
  }

   void setNauseaVal(int val){
    this.nauseaVal = val;
    notifyListeners();
  }

   void setDiarrheaVal(int val){
    this.diarrheaVal = val;
    notifyListeners();
  }

   void setOtherVal(String val){
    this.otherVal = val;
    notifyListeners();
  }
 
}