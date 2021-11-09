import 'dart:io';

import 'package:postgres/postgres.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';

class SymptomsDao {
  PostgreSQLConnection _symptomsRef;

  /* void saveMessage(Symptom message) {
    _symptomsRef.push().set(message.toJson());
  } */

  /*  Query getMessageQuery() {
    return _symptomsRef;
  }*/

  Future<List<Symptom>> getAlarmsByUser(String user) async {
    print("------- QUERY BED NUMBER $user -------");

    //SELECT *
    //FROM "SmartAlarmMobile_symptoms"
    //WHERE userlogged = 'teste'

    List<Symptom> res = List<Symptom>();

    print("[BD TESTE]: entrou");

    _symptomsRef = PostgreSQLConnection(
      '10.0.2.2',
      5435,
      'postgres',
      username: 'postgres',
      password: 'secret',
    );
    await _symptomsRef.open();

    print("[BD TESTE]: ${_symptomsRef.isClosed}");

    var result = await _symptomsRef.query(
        '''select * from "SmartAlarmMobile_symptoms" WHERE userlogged = '$user' ''');

    var aux;

    result.forEach((element) => {
       aux = Symptom(element[3], element[9], element[8], 
                    element[5], element[1], element[6],element[4], 
                    element[7], element[0], element[2], element[10]),
       res.add(aux)
    });  

    print("[BD TESTE]: RES = $result res = $res");
    return res;
  }

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
