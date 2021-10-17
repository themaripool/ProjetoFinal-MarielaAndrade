import 'dart:collection';
import 'package:flutter/material.dart';

class BedDataDetails extends LinkedListEntry<BedDataDetails> {
  int fc;
  int fr;
  int so;
  double te;
  int bedNumber;
  String dateDetails;

  BedDataDetails(
      {this.fc, this.fr, this.so, this.te, this.bedNumber, this.dateDetails});
}

class BedProvider extends ChangeNotifier {
  Map<String, LinkedList<BedDataDetails>> holder = {};
  var bedIds = [];

  void addToDataList(String bedId, BedDataDetails bedData) {
    if (holder.containsKey(bedId) == false) {
      holder[bedId] = LinkedList<BedDataDetails>();
      bedIds.add(bedId);
    }
    holder[bedId].add(bedData);
    if (holder[bedId].length == 30) {
      holder[bedId].remove(holder[bedId].first);
    }
    notifyListeners();
  }

  BedDataDetails dashboardData(String bedId) {
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
