import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Models/BedModel.dart';

class BedProvider extends ChangeNotifier {
  Map<String, LinkedList<BedData>> holder = {};
  var bedIds = [];

  void addToDataList(String bedId, BedData bedData) {
    if (holder.containsKey(bedId) == false) {
      holder[bedId] = LinkedList<BedData>();
      bedIds.add(bedId);
    }
    holder[bedId].add(bedData);
    if (holder[bedId].length == 30) {
      holder[bedId].remove(holder[bedId].first);
    }
    notifyListeners();
  }

  BedData dashboardData(String bedId) {
    return holder[bedId].last;
  }

  void eraseLists() {
    //salvar no firebase
    // apagar dados locais
    /* holder.forEach((key, value) {
      value.clear();
    });
    holder.clear(); */
  }
}
