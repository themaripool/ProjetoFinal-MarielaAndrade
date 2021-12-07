import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/Pages/InpatientSymptoms.dart';

class NavigationWebSymptoms extends StatelessWidget {
  String numberBed;
  NavigationWebSymptoms(this.numberBed);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sintomas do paciente"),
        centerTitle: true,
      ),
      body: PatientSymptoms(numberBed: numberBed, isInpatient: false),
    );
  }
}