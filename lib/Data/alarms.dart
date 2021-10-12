


class AlertModel {
  String clinicalStatus;
  String patientId;
  String bedId;
  String sectorId;
  String dateDetails;

  AlertModel(this.clinicalStatus, this.patientId, this.bedId, this.sectorId, this.dateDetails);

  AlertModel.fromJson(Map<dynamic, dynamic> json)
    : clinicalStatus = json['clinicalStatus'] as String,
      patientId = json['patientId'] as String,
      bedId = json['bedId'] as String,
      sectorId = json['sectorId'] as String,
      dateDetails = json['dateDetails'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
      'clinicalStatus': clinicalStatus,
      'patientId': patientId,
      'bedId': bedId,
      'sectorId': sectorId,
      'dateDetails': dateDetails,
    };
}
