import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';
import 'package:projeto_final_1/stub/mqtt_client_stub.dart'
    if (dart.library.html) 'package:projeto_final_1/stub/mqtt_browser_stub.dart'
    if (dart.library.io) 'package:projeto_final_1/stub/mqtt_server_stub.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/GeneralUseCase.dart';
import 'package:projeto_final_1/WebAppFiles/alertDialogWeb.dart';
import 'package:projeto_final_1/WebAppFiles/mainWeb.dart';
import 'package:typed_data/typed_data.dart';

/* ==================================================
GLOBAIS
===================================================== */

String broker = 'ws://192.168.0.4'; //windows
int port = 9001;
String clientIdentifier = 'SmartAlarm';
String queryHolder = "";

String username;
String passwd;
String appId;

BuildContext contextProvider;
BuildContext contextNavigation;

var Beds = List(2);

String sectorId;
String userId;
var _client;

/* ==================================================
CONSTANTES DOS TOPICOS
===================================================== */
String TOPIC_200 = "SmartAlarm/Data/";
String TOPIC_301 = "SmartAlarm/Alarms/Issued/";
String TOPIC_302 = "SmartAlarm/Alarms/Recognized/";
String TOPIC_303 = "SmartAlarm/Alarms/Cancelled/";
String TOPIC_401 = "SmartAlarm/Server/Application/Login/";
String TOPIC_402 = "SmartAlarm/Server/Application/InitialData/";
String TOPIC_601 = "SmartAlarm/Client/Application/Login/";
String TOPIC_602 = "SmartAlarm/Client/Application/InitialData/";
String TOPIC_604 = "SmartAlarm/Client/Application/History/";
String TOPIC_605 = "SmartAlarm/Client/Application/Query";
String TOPIC_405 = "SmartAlarm/Server/Application/Query";

var clientInitialData = TOPIC_602 + appId;
var serverInitialData = TOPIC_402 + appId;
var clientLoginTopic = TOPIC_601 + appId;
var serverLoginTopic = TOPIC_401 + appId;
var appHistory = TOPIC_604 + '2';

final _platform = Theme.of(contextProvider).platform;

class MQTTManagerWeb {
  var contentLoginRequest;

  /* ==================================================
    Inicialização do mqtt
  ===================================================== */

  void initializeMQTTClient(login, password, BuildContext context) {
    username = login;
    passwd = password;

    _client = createClientWithPort(broker, clientIdentifier, port, port);

    if (username == "marcos") {
      appId = "pacteste";
    } else if (username == "teste") {
      appId = "teste1";
    }

    contextNavigation = context;
    contextProvider = context;

    _client.port = port;
    _client.keepAlivePeriod = 20;
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;
    _client.onDisconnected = onDisconnected;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(appId)
        .keepAliveFor(60)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    print('[Mqtt Web]: Mosquitto client connecting....');
    _client.connectionMessage = connMess;
  }

  void connect() async {
    assert(_client != null);
    try {
      await _client.connect();
    } on Exception catch (e) {
      print('[Mqtt Web]: client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('[Mqtt Web]: Disconnected');
    _client.disconnect();
  }

  void onSubscribed(String topic) {
    print('[Mqtt Web]: Subscription confirmed for topic $topic');
  }

  void onDisconnected() {
    print('[Mqtt Web]: OnDisconnected client callback - Client disconnection');
    print(
        '[Mqtt Web]: return code ${_client.connectionStatus.returnCode} mqtt ${MqttConnectReturnCode.noneSpecified}');
    if (_client.connectionStatus.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print(
          '[Mqtt Web]: OnDisconnected callback is solicited, this is correct');
    }
  }

  void onConnected() {
    print('[Mqtt Web]: Mosquitto client connected....');
    app_request_login();
    onMessageArrived();
  }

   /* ==================================================
    Recebimentos das menssagens 
  ===================================================== */

  void onMessageArrived() {
    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final contentPayload =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      if (c[0].topic == clientLoginTopic) {
        var content = jsonDecode(contentPayload);
        print("[Mqtt Web]: content = $content");
        contentLoginRequest = content['CD'];

        if (contentLoginRequest == "2") {
          userId = content['UI'].toString();
          sectorId = content['SI'].toString();

          Provider.of<BedProvider>(contextNavigation, listen: false)
              .setCurrentUserName(username);

          print("[Mqtt Web]: SECTORID = $sectorId, userid= $userId");

          login_accepted();

          Navigator.push(contextNavigation,
              MaterialPageRoute(builder: (contextNavigation) {
            return MyAppWeb();
          }));
        } else if (contentLoginRequest != "2") {
          _client.disconnect();
          showErrorLoginAlertDialog(contextNavigation);
        }
      } else if (c[0].topic == clientInitialData) {
        receive_InitialData(contentPayload);
      } else {
        var subTopics = c[0].topic.split("/");
        print("TOOOPICO ELSE = ${c[0].topic}");

        if (c[0].topic.contains(TOPIC_200)) {
          receive_data(contentPayload, subTopics);
        } else if (c[0].topic.contains(TOPIC_301)) {
          recv_alarm_new(contentPayload, subTopics);
        } else if (c[0].topic.contains(TOPIC_302)) {
        } else if (c[0].topic.contains(TOPIC_303)) {
          recv_alarm_cancel(contentPayload, subTopics);
        } else if (c[0].topic.contains(TOPIC_605)) {
          print("entrou topico 405 - ${c[0].topic} - ");
          getPGQuery(contentPayload);
        }
      }
    });
  }

   /* ==================================================
    Logout
  ===================================================== */

  void app_request_logout() {
    BedProvider bedProvider =
        Provider.of<BedProvider>(contextProvider, listen: false);
    bedProvider.eraseLists();
    _client.disconnect();
  }

   /* ==================================================
    Login
  ===================================================== */

  void app_request_login() {
    print('[Mqtt Web]: Subscribing to ...$clientLoginTopic topic');

    _client.subscribe(clientLoginTopic, MqttQos.atLeastOnce);

    Map<String, dynamic> str = {
      'CD': '1',
      'DT': '1632084368',
      'UN': '$username',
      'PW': '$passwd'
    };

    print('[Mqtt Web]: user $username password $passwd');

    String json = jsonEncode(str);
    Uint8List data = utf8.encode(json);
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    print('[Mqtt Web]: publishMessage ...$str');
    _client.publishMessage(serverLoginTopic, MqttQos.atLeastOnce, dataBuffer);
  }

   /* ==================================================
    Login aceito
  ===================================================== */

  void login_accepted() {
    print("[Mqtt Web]: Login aceito");

    _client.subscribe(clientInitialData, MqttQos.atLeastOnce);
    _client.unsubscribe(clientLoginTopic);

    Map<String, dynamic> str = {
      'UI': int.parse(userId),
      'SI': int.parse(sectorId)
    };

    String json = jsonEncode(str);

    Uint8List data = utf8.encode(json);
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    _client.publishMessage(serverInitialData, MqttQos.atLeastOnce, dataBuffer);
  }

   /* ==================================================
    Mensagens para conexão com o banco de dados via mqtt
  ===================================================== */

  void makePGQuery(queryName, bedId) {
    print("[Mqtt Web]: Connect to postgres");

    queryHolder = queryName;

    var bdCliente = TOPIC_605 + '/$userId';
    var bdServer = TOPIC_405 + '/$userId';

    _client.subscribe(bdCliente, MqttQos.atLeastOnce);

    Map<String, dynamic> str = {
      'QR': '$queryName',
      'UN':
          '${Provider.of<BedProvider>(contextNavigation, listen: false).currentUserName}',
      'BN': '$bedId',
    };

    String json = jsonEncode(str);
    Uint8List data = utf8.encode(json);
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    _client.publishMessage(bdServer, MqttQos.atLeastOnce, dataBuffer);
  }

  void insertSymptomsQuery(
      queryName,
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
      String bednumber) {
    print("[Mqtt Web]: Connect to postgres - insert on db");

    var bdCliente = TOPIC_605 + '/$userId';
    var bdServer = TOPIC_405 + '/$userId';

    _client.subscribe(bdCliente, MqttQos.atLeastOnce);

    Map<String, dynamic> str = {
      'QR': '$queryName',
      'conscience': '$conscience',
      'diarrea': '$diarrea',
      'date': '$date',
      'headache': '$headache',
      'hour': '$hour',
      'nausea': '$nausea',
      'others': '$others',
      'ox': '$ox',
      'pain': '$pain',
      'tiredness': '$tiredness',
      'userlogged': '$userlogged',
      'bednumber': '$bednumber',
    };

    String json = jsonEncode(str);
    Uint8List data = utf8.encode(json);
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    _client.publishMessage(bdServer, MqttQos.atLeastOnce, dataBuffer);
  }

  void insertAlarmQuery(
      queryName,
      String clinicalStatus,
      String patientId,
      String bedId,
      String sectorId,
      String dateAndMonth,
      String hourAndMinute,
      bool isCancelled) {
    print("[Mqtt Web]: Connect to postgres - insert on db");

    var bdCliente = TOPIC_605 + '/$userId';
    var bdServer = TOPIC_405 + '/$userId';

    _client.subscribe(bdCliente, MqttQos.atLeastOnce);

    Map<String, dynamic> str = {
      'QR': '$queryName',
      'clinicalStatus': '$clinicalStatus',
      'patientId': '$patientId',
      'bedId': '$bedId',
      'sectorId': '$sectorId',
      'dateAndMonth': '$dateAndMonth',
      'hourAndMinute': '$hourAndMinute',
      'isCancelled': '$isCancelled',
    };

    String json = jsonEncode(str);
    Uint8List data = utf8.encode(json);
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    _client.publishMessage(bdServer, MqttQos.atLeastOnce, dataBuffer);
  }

  void getPGQuery(contentPayload) {
    var bdCliente = TOPIC_605 + '/$userId';
    print("[Mqtt Web]: conectou");
    var content = jsonDecode(contentPayload);

    if (queryHolder == 'AlarmsByBed' || queryHolder == 'allAlarms' ) {
      List<Alert> res = List<Alert>();
      var aux;

      content.forEach((element) => {
            aux = Alert(element[0], element[1], element[2], element[3],
                element[4], element[5], element[6]),
            res.add(aux)
          });

      BedProvider bedProvider =
          Provider.of<BedProvider>(contextProvider, listen: false);

      bedProvider.setAlertsListByBed(res);
      print("PAYLOAD == $content RES == $res");
    } else if (queryHolder == 'SymptomsByBed') {
      List<Symptom> res = List<Symptom>();
      var aux;

      content.forEach((element) => {
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

      BedProvider bedProvider =
          Provider.of<BedProvider>(contextProvider, listen: false);

      bedProvider.setSymptomListByBed(res);
      print("PAYLOAD == $content RES == $res");
    }
    _client.unsubscribe(bdCliente);
  }

 /* ==================================================
    Recebimento dos dados iniciais

    Get the number of beds per Sector.
    It is a list separated by ';' with the sector number, number of beds
    Example: 1,5; 2,1   (Sector 1 has 5 beds, and sector 2 has one bed)
  ===================================================== */

  void receive_InitialData(pt) {
    var content = jsonDecode(pt);
    var l_bedNums = content['BN']; // 3,2

    if (l_bedNums.contains(";")) {
      l_bedNums = l_bedNums.split(';');
    } else {
      l_bedNums = [l_bedNums];
    }

    var SECTOR_NUMBEDS = {};
    for (var i = 0; i < l_bedNums.length; i++) {
      var tmp = l_bedNums[i].split(",");
      SECTOR_NUMBEDS[tmp[0]] = tmp[1];

      sectorId = tmp[0];

      var sectorData = TOPIC_200 + sectorId + '/#';
      var alarmIssued = TOPIC_301 + sectorId + '/#';
      var alarmRecognized = TOPIC_302 + sectorId + '/#';
      var alarmCancelled = TOPIC_303 + sectorId + '/#';

      _client.subscribe(sectorData,MqttQos.atLeastOnce); 
      _client.subscribe(alarmIssued,MqttQos.atLeastOnce); 
      _client.subscribe(alarmRecognized,MqttQos.atLeastOnce); 
      _client.subscribe(alarmCancelled,MqttQos.atLeastOnce); 
    }
    _client.subscribe(appHistory, MqttQos.atLeastOnce);
    _client.unsubscribe(serverInitialData);
  }

  /* ==================================================
    Recebimento dos dados do sensor
  ===================================================== */

  void receive_data(contentPayload, subTopics) {
    print("[Mqtt Web]: RECEIVE DATA ");

    print("[Mqtt Web]: subtopics = $subTopics");

    String patientId = subTopics.removeLast();
    String bedId = subTopics.removeLast(); 
    String sectorId = subTopics.removeLast();

    print("[Mqtt Web]: recv_data_update bedId:   $patientId $bedId $sectorId");

    int intBedId = int.parse(bedId);
    assert(intBedId is int);

    var content = jsonDecode(contentPayload);
    print("[Mqtt Web]: content = $content");

    var now = new DateTime.now();
    now.toUtc();
    final f = new DateFormat.Hms();

    final _platform = Theme.of(contextProvider).platform;

    String formattedDate = f.format(now);

    BedData data = BedData(
        fc: content['FC'],
        fr: content['FR'],
        so: content['SO'],
        te: content['TE'],
        bedNumber: int.parse(bedId),
        dateDetails: formattedDate,
        sector: sectorId,
        cs: content['CS']);

    print("[Mqtt Web]: BED DATA ${data.sector} bedid = $bedId");

    BedProvider bedProvider = Provider.of<BedProvider>(contextProvider, listen: false);

    print("[Mqtt Web]: BED DATA add map $bedId no ${data.sector}");

    bedProvider.addToSectorMap(bedId, sectorId);
    bedProvider.addToDataList(bedId, data);
  }

  /* ==================================================
    Cancelamento do alarme
  ===================================================== */

  void recv_alarm_cancel(content, subTopics) {
    print("[Mqtt Web]: Alarm cancel");
    String bedId = subTopics.removeLast();
    String sectorId = subTopics.removeLast();

    String clinicalStatus = content['CS'].toString();
    String patientId = '';

    _sendMessage(clinicalStatus, patientId, bedId, sectorId, true);
  }

  /* ==================================================
    Novo alarme
  ===================================================== */

  void recv_alarm_new(contentPayload, subTopics) {
    String clinicalStatus = subTopics.removeLast();
    String patientId = subTopics.removeLast();
    String bedId = subTopics.removeLast();
    String sectorId = subTopics.removeLast();
    var content = jsonDecode(contentPayload);

    showDialog(
        context: contextNavigation,
        builder: (context) => AlertDialogWeb(clinicalStatus, bedId, content));

    _sendMessage(clinicalStatus, patientId, bedId, sectorId, false);
  }

  /* ==================================================
    Salvamento do alarme no banco de dados -  TODO
  ===================================================== */

  void _sendMessage(String clinicalStatus, String patientId, String bedId,
      String sectorId, bool isCancelled) {
    var now = new DateTime.now();
    now.toUtc();

    var diaEMes = DateFormat.yMd();
    String formattedDiaEMes = diaEMes.format(now);

    final f = new DateFormat.Hm();

    final _platform = Theme.of(contextProvider).platform;

    String formattedDateHora = f.format(now);

    final alert = Alert(clinicalStatus, patientId, bedId, sectorId,
        formattedDiaEMes, formattedDateHora, isCancelled);
  }

  /* ==================================================
    Publicação da mensagens de recebimento de alarmes
  ===================================================== */

  void send_alarm_recognition(id) {
    var nameBed = "bedNumber" + id; 
    var nameAlarm = "bedAlarm" + id;

    Map<String, dynamic> str = {
      "ID": Random.secure().nextInt(1000),
      "DT": 2313435,
      "UI": 2
    };

    String json = jsonEncode(str);

    Uint8List data = utf8.encode(json);
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    var RECOGNIZED_TOPIC = TOPIC_302 + '3' + "/" + id;
    _client.publishMessage(RECOGNIZED_TOPIC, MqttQos.atLeastOnce, dataBuffer);
  }
}
