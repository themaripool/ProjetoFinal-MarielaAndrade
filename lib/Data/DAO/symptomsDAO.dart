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

  Query getAllSymptoms() {
    print("------- QUERY ALL BEDS ALAMS -------");
    return _symptomsRef.orderByChild("hourAndMinute");
  }
}
