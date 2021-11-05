import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/GeneralUseCase.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';

void main() {
  test('Checking fr and color returned should be green', () {
    final vm = InpatientViewModel();
    BedData bedtestData = BedData(fc: 132, fr: 13, so: 94, te: 35.2, bedNumber: 1, dateDetails: "21/01", sector: "1");
    var result = vm.checkInpatient(bedtestData, 0);
    expect(result, Colors.green);
  });

  test('Checking fc and color returned should be red', () {
    final vm = InpatientViewModel();
    BedData bedtestData = BedData(fc: 132, fr: 13, so: 94, te: 35.2, bedNumber: 1, dateDetails: "21/01", sector: "1");
    var result = vm.checkInpatient(bedtestData, 1);
    expect(result, Colors.red);
  });

  test('Checking te and color returned should be blue', () {
    final vm = InpatientViewModel();
    BedData bedtestData = BedData(fc: 132, fr: 13, so: 94, te: 35.2, bedNumber: 1, dateDetails: "21/01", sector: "1");
    var result = vm.checkInpatient(bedtestData, 2);
    expect(result, Colors.blue);
  });

  test('Checking so and color returned should be blue', () {
    final vm = InpatientViewModel();
    BedData bedtestData = BedData(fc: 132, fr: 13, so: 94, te: 35.2, bedNumber: 1, dateDetails: "21/01", sector: "1");
    var result = vm.checkInpatient(bedtestData, 3);
    expect(result, Colors.blue);
  });

  test('Checking title by index and should be Oxigênio', () {
    final vm = InpatientViewModel();
    var result = vm.setTitle(4);
    expect(result, "Oxigênio");
  });

  test('Checking detailsTitle by index and should be temperature.png', () {
    final vm = InpatientViewModel();
    var result = vm.detailsTitle(2);
    expect(result, "Temperatura");
  });

}