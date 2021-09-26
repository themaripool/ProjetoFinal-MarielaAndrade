import 'package:flutter/material.dart';

class BedData {
  int fc;
  int fr;
  int so;
  double te;
  int bedNumber;

  BedData({this.fc, this.fr, this.so, this.te, this.bedNumber});
}

class BedProvider extends ChangeNotifier {
  List<BedData> _bedDataList = [];

  List<BedData> get bedInfo {
    return [..._bedDataList];
  }

  get bedNumber {
    return this.bedNumber;
  }

  searchBedNumberInList(int bedSearched) {
    var i = 0;
    for (var bed in _bedDataList) {
      if (bed.bedNumber == bedSearched) {
        return i;
      }
      i++;
    }
    return -1;
  }

  set bedInfo(List<BedData> newBedData) {
    _bedDataList = newBedData;
    notifyListeners();
  }

  void addBedInfo(BedData newBedData) {
    _bedDataList.add(newBedData);
    notifyListeners();
  }

  void addBedAtIndex(int index, BedData newBedData) {
    _bedDataList.insert(index, newBedData);
    notifyListeners();
  }

  void removeBedInfo(int index) {
    _bedDataList.removeAt(index);
    notifyListeners();
  }
}