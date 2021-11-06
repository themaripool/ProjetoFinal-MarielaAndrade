import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Models/Models.dart';

class BedProvider extends ChangeNotifier {
  Map<String, LinkedList<BedData>> holder = {};
  Map<String, String> sectorMap = {};
  var bedIds = [];
  String selectedSector;

  void setSector(String setor) {
    if (setor == "setor 3") {
      selectedSector = "3";
    } else if (setor == "setor 4") {
      selectedSector = "4";
    } else if (setor == "setor 5") {
      selectedSector = "5";
    } else if (setor == "todos") {
      selectedSector = "0";
    }
    print("[DEBUG SETOR]: $selectedSector");
    notifyListeners();
  }

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

  void addToSectorMap(String bedId, String sectorId) {
    if (sectorMap.containsKey(bedId) == false) {
      sectorMap[bedId] = sectorId;
    }
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
