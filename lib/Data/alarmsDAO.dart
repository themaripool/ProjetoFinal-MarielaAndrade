import 'package:firebase_database/firebase_database.dart';
import 'alarms.dart';

class AlarmsDao {
  final DatabaseReference _alarmRef =
      FirebaseDatabase.instance.reference().child('alarms');

  void saveMessage(AlertModel message) {
    _alarmRef.push().set(message.toJson());
  }

  Query getMessageQuery() {
    return _alarmRef;
  }
}
