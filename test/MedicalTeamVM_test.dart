// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';

void main() {
  test('Color returned should be red', () {
    final vm = MedicalTeamViewModel();
    BedData bedtestData = BedData(fc: 132, fr: 13, so: 94, te: 35.2, bedNumber: 1, dateDetails: "21/01", sector: "1");
    var result = vm.checkInpatientStatusGrid(bedtestData);
    expect(result[0], Colors.red);
  });

  test('Text returned should be CRÍTICO', () {
    final vm = MedicalTeamViewModel();
    BedData bedtestData = BedData(fc: 132, fr: 13, so: 94, te: 35.2, bedNumber: 1, dateDetails: "21/01", sector: "1");
    var result = vm.checkInpatientStatusGrid(bedtestData);
    expect(result[1], "CRÍTICO");
  });

  test('Check number os boxes on Severity component', () {
    final vm = MedicalTeamViewModel();
    var result = vm.checkSeverityBoxes(Colors.green);
    expect(result, 1);
  });
}
