import 'package:projeto_final_1/Models/Models.dart';
import '../Data.dart';

class SymptomsDao {
  final DatabaseReference _symptomsRef =
      FirebaseDatabase.instance.reference().child('symptoms');

  void saveMessage(Symptom message) {
    _symptomsRef.push().set(message.toJson());
  }

  Query getMessageQuery() {
    return _symptomsRef;
  }

  Query getAlarmsByUser(String user) {
    print("------- QUERY BED NUMBER $user -------");
    return _symptomsRef.orderByChild("user").equalTo(user);
  }
}
