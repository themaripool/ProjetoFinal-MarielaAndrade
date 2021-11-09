import 'package:postgres/postgres.dart';

class SymptomsDao {
  PostgreSQLConnection _symptomsRef;

  /* void saveMessage(Symptom message) {
    _symptomsRef.push().set(message.toJson());
  } */

  /*  Query getMessageQuery() {
    return _symptomsRef;
  }

  Query getAlarmsByUser(String user) {
    print("------- QUERY BED NUMBER $user -------");
    return _symptomsRef.host;//.orderByChild("user").equalTo(user);
  } */

  void initPostgres() async {
    _symptomsRef = PostgreSQLConnection(
      '10.0.2.2',
      5435,
      'postgres',
      username: 'postgres',
      password: 'secret',
    );
    await _symptomsRef.open();

    print('Connected to Postgres database...');
  }

  Future<void> saveSymptom(
      String conscience,
      String diarrea,
      String date,
      String headache,
      String hour,
      String nausea,
      String others,
      String ox,
      String pain,
      String tiredness,
      String userlogged) async {
      
      _symptomsRef = PostgreSQLConnection(
      '10.0.2.2',
      5435,
      'postgres',
      username: 'postgres',
      password: 'secret',
    );
    await _symptomsRef.open();
    if (_symptomsRef.isClosed == false) {
      await _symptomsRef.query(
        'insert into "SmartAlarmMobile_symptoms" (conscience,diarrea,date,headache,hour,nausea,others,ox,pain,tiredness,userlogged) '
        'values(@conscience,@diarrea,@date,@headache,@hour,@nausea,@others,@ox,@pain,@tiredness,@userlogged)',
        substitutionValues: {
          'conscience': conscience,
          'diarrea': diarrea,
          'date': date,
          'headache': headache,
          'hour': hour,
          'nausea': nausea,
          'others': others,
          'ox': ox,
          'pain': pain,
          'tiredness': tiredness,
          'userlogged': userlogged,
        },
        allowReuse: true,
      );
    }
  }
}
