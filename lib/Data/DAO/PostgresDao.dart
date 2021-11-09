import 'package:postgres/postgres.dart';
import 'package:projeto_final_1/Models/Models.dart';

import '../Data.dart';

class PostgresDao {
  PostgreSQLConnection _symptomsRef;

  Future<List<Symptom>> getSymptomsByUser(String user) async {
    //SELECT *
    //FROM "SmartAlarmMobile_symptoms"
    //WHERE userlogged = 'teste'

    List<Symptom> res = List<Symptom>();

    print("[BD TESTE]: entrou by user");

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
          aux = Symptom(
              element[3],
              element[9],
              element[8],
              element[5],
              element[1],
              element[6],
              element[4],
              element[7],
              element[0],
              element[2],
              element[10]),
          res.add(aux)
        });

    print("[BD TESTE]: RES = $result res = $res");
    return res;
  }

  Future<List<Symptom>> getSymptomsByBed(String bed) async {
    //SELECT *
    //FROM "SmartAlarmMobile_symptoms"
    //WHERE bed = 'bed'

    print("[BD TESTE]: entrou by bed");

    List<Symptom> res = List<Symptom>();

    _symptomsRef = PostgreSQLConnection(
      '10.0.2.2',
      5435,
      'postgres',
      username: 'postgres',
      password: 'secret',
    );
    await _symptomsRef.open();

    var result = await _symptomsRef.query(
        '''select * from "SmartAlarmMobile_symptoms" WHERE bednumber = '$bed' ''');

    var aux;

    result.forEach((element) => {
          aux = Symptom(
              element[3],
              element[9],
              element[8],
              element[5],
              element[1],
              element[6],
              element[4],
              element[7],
              element[0],
              element[2],
              element[10]),
          res.add(aux)
        });
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
      String userlogged,
      String bednumber) async {
    _symptomsRef = PostgreSQLConnection(
      '10.0.2.2',
      5435,
      'postgres',
      username: 'postgres',
      password: 'secret',
    );
    await _symptomsRef.open();
    if (bednumber == null) {
      //paciente está em casa
      bednumber = "-1";
    }

    if (_symptomsRef.isClosed == false) {
      var result = await _symptomsRef.query(
        'insert into "SmartAlarmMobile_symptoms" (conscience,diarrea,date,headache,hour,nausea,others,ox,pain,tiredness,userlogged,bednumber) '
        'values(@conscience,@diarrea,@date,@headache,@hour,@nausea,@others,@ox,@pain,@tiredness,@userlogged,@bednumber)',
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
          'bednumber': bednumber,
        },
        allowReuse: true,
      );
      print('[BD TESTE]: $result');
      Provider.of<Symptoms>(contextProvider, listen: false).eraseAllData();
    }
  }


  /* ALARMES */

  Future<void> saveAlert(
      String clinicalStatus,
      String patientId,
      String bedId,
      String sectorId,
      String dateAndMonth,
      String hourAndMinute,
      bool isCancelled) async {
    _symptomsRef = PostgreSQLConnection(
      '10.0.2.2',
      5435,
      'postgres',
      username: 'postgres',
      password: 'secret',
    );
    await _symptomsRef.open();

    if (_symptomsRef.isClosed == false) {
      var result = await _symptomsRef.query(
        'insert into "SmartAlarmMobile_alarms" (clinicalstatus,patientId,bedId,sectorId,date,hour,iscancelled) '
        'values(@clinicalstatus,@patientId,@bedId,@sectorId,@date,@hour,@iscancelled)',
        substitutionValues: {
          'clinicalstatus': clinicalStatus,
          'patientId': patientId,
          'bedId': bedId,
          'sectorId': sectorId,
          'date': dateAndMonth,
          'hour': hourAndMinute,
          'iscancelled': isCancelled,
        },
        allowReuse: true,
      );
      print('[BD TESTE]: $result');
    }
  }

   Future<List<Alert>> getAllAlerts() async {
    //SELECT *
    //FROM "SmartAlarmMobile_alarms"

    List<Alert> res = List<Alert>();

    print("[BD TESTE]: entrou all alarms");

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
        '''select * from "SmartAlarmMobile_alarms" ''');

    var aux;

    result.forEach((element) => {
          aux = Alert(
              element[0],
              element[1],
              element[2],
              element[3],
              element[4],
              element[5],
              element[6]),
          res.add(aux)
        });

    print("[BD TESTE]: RES = $result res = $res");
    return res;
  }

  Future<List<Alert>> getAlertsByBed(String bed) async {
    //SELECT *
    //FROM "SmartAlarmMobile_alarms"

    List<Alert> res = List<Alert>();

    print("[BD TESTE]: entrou getAlertsByBed");

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
        '''select * from "SmartAlarmMobile_alarms"  WHERE bedid = '$bed' ''');

    var aux;

    result.forEach((element) => {
          aux = Alert(
              element[0],
              element[1],
              element[2],
              element[3],
              element[4],
              element[5],
              element[6]),
          res.add(aux)
        });

    print("[BD TESTE]: RES = $result res = $res");
    return res;
  }


}
