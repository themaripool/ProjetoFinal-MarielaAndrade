
import 'package:flutter/material.dart';

class News2 extends ChangeNotifier {
  
  double respiratoryFreq;  //frequencia respiratoria
  double bloodPressure; //pressao arterial
  double pulse; //pulso 
  double conscience; //consciencia
  double temperature; //temperatura
  double sp; //sp 02

  News2(this.respiratoryFreq, this.bloodPressure, this.pulse, this.conscience, this.temperature, this.sp);

  // Atualizacoes dos dados usando provider

  void setRespiratoryFreq(double val){
    this.respiratoryFreq = val;
    notifyListeners();
  }

  String toStringRespiratoryFreq(){
    return '$respiratoryFreq';
  }

   void setBloodPressure(double val){
    this.bloodPressure = val;
    notifyListeners();
  }

  String toStringBloodPressure(){
    return '$bloodPressure';
  }

   void setPulse(double val){
    this.pulse = val;
    notifyListeners();
  }

  String toStringPulse(){
    return '$pulse';
  }

   void setConscience(double val){
    this.conscience = val;
    notifyListeners();
  }

  String toStringConscience(){
    return '$conscience';
  }

   void setTemperature(double val){
    this.temperature = val;
    notifyListeners();
  }

  String toStringTemperature(){
    return '$temperature';
  }

   void setSp(double val){
    this.sp = val;
    notifyListeners();
  }

  String toStringSp(){
    return '$sp';
  }

}