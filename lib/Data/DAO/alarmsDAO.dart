import '../Data.dart';
import '../../Models/AlertModel.dart';

class AlarmsDao {
  final DatabaseReference _alarmRef =
      FirebaseDatabase.instance.reference().child('alarms');

  void saveMessage(Alert message) {
    _alarmRef.push().set(message.toJson());
  }

  Query getMessageQuery() {
    return _alarmRef;
  }

  Query getAlarmsByBedQuery(String bedId) {
    print("------- QUERY BED NUMBER $bedId -------");
    return _alarmRef.orderByChild("bedId").equalTo(bedId);
  }
}
