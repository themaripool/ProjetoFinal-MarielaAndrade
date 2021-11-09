
class Alert {
  String clinicalStatus;
  String patientId;
  String bedId;
  String sectorId;
  String dateAndMonth;
  String hourAndMinute;
  bool isCancelled;

  Alert(this.clinicalStatus, this.patientId, this.bedId, this.sectorId,
      this.dateAndMonth, this.hourAndMinute, this.isCancelled);

  /* Alert.fromJson(Map<dynamic, dynamic> json)
      : clinicalStatus = json['clinicalStatus'] as String,
        patientId = json['patientId'] as String,
        bedId = json['bedId'] as String,
        sectorId = json['sectorId'] as String,
        dateAndMonth = json['dateAndMonth'] as String,
        hourAndMinute = json['hourAndMinute'] as String,
        isCancelled = json['isCancelled'] as bool;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'clinicalStatus': clinicalStatus,
        'patientId': patientId,
        'bedId': bedId,
        'sectorId': sectorId,
        'dateAndMonth': dateAndMonth,
        'hourAndMinute': hourAndMinute,
        'isCancelled': isCancelled,
      }; */
}
