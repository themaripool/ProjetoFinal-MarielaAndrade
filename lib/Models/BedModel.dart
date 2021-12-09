import 'dart:collection';
//so = oxigenio
// fc - frequencia cardiaca == pulso
// te = temperatura
// fr = frequencia respiratoria
class BedData extends LinkedListEntry<BedData> {
  int fc;
  int fr;
  int so;
  double te;
  int bedNumber;
  String sector;
  String dateDetails;
  int cs;

  BedData(
      {this.fc, this.fr, this.so, this.te, this.bedNumber, this.dateDetails, this.sector, this.cs});
}
