import 'dart:collection';

class BedData extends LinkedListEntry<BedData> {
  int fc;
  int fr;
  int so;
  double te;
  int bedNumber;
  String sector;
  String dateDetails;

  BedData(
      {this.fc, this.fr, this.so, this.te, this.bedNumber, this.dateDetails, this.sector});
}
