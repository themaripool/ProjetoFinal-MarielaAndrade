import 'package:flutter/material.dart';
import 'package:projeto_final_1/Models/Models.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/GeneralUseCase.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';
import 'package:typed_data/typed_data.dart';
import '../Data.dart';

/* ==================================================
GLOBAIS
===================================================== */

//String broker = 'ws://192.168.5.178'; //macos
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
final _client = MqttServerClient.withPort(broker, clientIdentifier, port);

String sectorId;
String userId;

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

var clientInitialData =
    TOPIC_602 + appId; //"SmartAlarm/Client/Application/InitialData/teste1"
var serverInitialData =
    TOPIC_402 + appId; //"SmartAlarm/Server/Application/InitialData/teste1"
var clientLoginTopic =
    TOPIC_601 + appId; //"SmartAlarm/Client/Application/Login/teste1";
var serverLoginTopic =
    TOPIC_401 + appId; //"SmartAlarm/Server/Application/Login/teste1"
var appHistory = TOPIC_604 + '2'; //"SmartAlarm/Client/Application/History"

class MQTTManager {
  var contentLoginRequest;
  void initializeMQTTClient(login, password, BuildContext context) {
    username = login;
    passwd = password;

    if (username == "marcos") {
      appId = "pacteste";
    } else if (username == "teste") {
      appId = "teste1";
    }

    contextNavigation = context;
    contextProvider = context;

    _client.useWebSocket = true;
    _client.port = port;
    _client.keepAlivePeriod = 20;
    _client.secure = false;
    //_client.logging(on: true);

    /// Add the successful connection callback
    _client.onConnected = onConnected;
    _client.onSubscribed = onSubscribed;
    _client.onDisconnected = onDisconnected;

    final MqttConnectMessage connMess = MqttConnectMessage()
        .withClientIdentifier(appId)
        .keepAliveFor(60)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);

    print("[Mqtt App]: Mosquitto client connecting....");
    _client.connectionMessage = connMess;
  }

  // Connect to the host
  // ignore: avoid_void_async
  void connect() async {
    assert(_client != null);
    try {
      await _client.connect();
    } on Exception catch (e) {
      print('[Mqtt App]: Client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('[Mqtt App]: Disconnected');
    _client.disconnect();
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('[Mqtt App]: Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('[Mqtt App]: OnDisconnected client callback - Client disconnection');
    print(
        '[Mqtt App]: return code ${_client.connectionStatus.returnCode} mqtt ${MqttConnectReturnCode.noneSpecified}');
    if (_client.connectionStatus.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print(
          '[Mqtt App]: OnDisconnected callback is solicited, this is correct');
    }
  }

  /// The successful connect callback
  void onConnected() {
    print('[Mqtt App]: Mosquitto client connected....');
    app_request_login();
    onMessageArrived();
  }

  void onMessageArrived() {
    _client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final recMess = c[0].payload as MqttPublishMessage;
      final contentPayload =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      if (c[0].topic == clientLoginTopic) {
        var content = jsonDecode(contentPayload);
        print("[Mqtt App]: content = $content");

        contentLoginRequest = content['CD'];

        if (contentLoginRequest == "2") {
          userId = content['UI'].toString();
          sectorId = content['SI'].toString();
          Provider.of<BedProvider>(contextNavigation, listen: false)
              .setCurrentUserName(username);
          print("[Mqtt App]: SECTORID = $sectorId, userid= $userId");
          login_accepted();
          if (appId == "teste1") {
            Navigator.push(contextNavigation,
                MaterialPageRoute(builder: (contextNavigation) {
              return Home();
            }));
          } else {
            Navigator.push(contextNavigation,
                MaterialPageRoute(builder: (contextNavigation) {
              return HomePatient();
            }));
          }
        } else if (contentLoginRequest != "2") {
          _client.disconnect();
          showErrorLoginAlertDialog(contextNavigation);
        }
      } else if (c[0].topic == clientInitialData) {
        receive_InitialData(contentPayload);
      } else {
        print("[Mqtt App]: else - topico: ${c[0].topic} -----");
        var subTopics = c[0].topic.split("/");

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

  void app_request_logout() {
    BedProvider bedProvider =
        Provider.of<BedProvider>(contextProvider, listen: false);
    bedProvider.eraseLists();
    _client.disconnect();
  }

  void app_request_login() {
    print('[Mqtt App]: Subscribing to ...$clientLoginTopic topic');

    _client.subscribe(clientLoginTopic, MqttQos.atLeastOnce);

    Map<String, dynamic> str = {
      'CD': '1',
      'DT': '1632084368',
      'UN': '$username',
      'PW': '$passwd'
    };

    print('[Mqtt App]: user $username password $passwd');

    String json = jsonEncode(str);
    Uint8List data = utf8.encode(json);
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    print('[Mqtt App]: publishMessage ...$str');
    _client.publishMessage(serverLoginTopic, MqttQos.atLeastOnce, dataBuffer);
  }

  void login_accepted() {
    print("[Mqtt App]: Login aceito");

    _client.subscribe(clientInitialData, MqttQos.atLeastOnce);
    _client.unsubscribe(clientLoginTopic);

    Map<String, dynamic> str = {
      'UI': int.parse(userId),
      'SI': int.parse(sectorId)
    };

    String json = jsonEncode(str);
    print('[Mqtt App]: publishMessage ...$str');

    Uint8List data = utf8.encode(json);
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    _client.publishMessage(serverInitialData, MqttQos.atLeastOnce, dataBuffer);
  }

  //***************************************************************************************** */

  void makePGQuery(queryName, bedId) {
    print("[Mqtt APP]: Connect to postgres");

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
    print("[Mqtt APP]: Connect to postgres - insert on db");

    /*  String TOPIC_605 = "SmartAlarm/Client/Application/Query";
    String TOPIC_405 = "SmartAlarm/Server/Application/Query"; */

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
    print("[Mqtt APP]: Connect to postgres - insert on db");

    /*  String TOPIC_605 = "SmartAlarm/Client/Application/Query";
    String TOPIC_405 = "SmartAlarm/Server/Application/Query"; */

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
    print("[Mqtt APP]: conectou");
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
    } else if (queryHolder == 'SymptomsByBed' || queryHolder == 'SymptomsByUser') {
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

  ///***************************************************************************************** */

// ignore: non_constant_identifier_names
  void receive_InitialData(pt) {
    var content = jsonDecode(pt);

    print("[Mqtt App]: initial data content = $content");

    // Get the number of beds per Sector.
    // It is a list separated by ';' with the sector number, number of beds
    // Example: 1,5; 2,1   (Sector 1 has 5 beds, and sector 2 has one bed)
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

      _client.subscribe(
          sectorData,
          MqttQos
              .atLeastOnce); //mqtt.subscribe(TOPIC_200 + "/" + MySectorId + "/#");
      _client.subscribe(
          alarmIssued,
          MqttQos
              .atLeastOnce); // mqtt.subscribe(TOPIC_301 + "/" + MySectorId + "/#");
      _client.subscribe(
          alarmRecognized,
          MqttQos
              .atLeastOnce); // mqtt.subscribe(TOPIC_302 + "/" + MySectorId + "/#");
      _client.subscribe(
          alarmCancelled,
          MqttQos
              .atLeastOnce); // mqtt.subscribe(TOPIC_303 + "/" + MySectorId + "/#");
    }
    _client.subscribe(appHistory, MqttQos.atLeastOnce);
    _client.unsubscribe(serverInitialData);
  }

  void receive_data(contentPayload, subTopics) {
    print("[Mqtt App]: receive data");

    print("[Mqtt App]: subtopics = $subTopics");

    // subTopics[..., Sector, Bed, Patient]
    String patientId = subTopics.removeLast();
    String bedId = subTopics
        .removeLast(); // id da cama ta vindo como 4 ou 5, de acordo com a cmaa ele salva o payl
    String sectorId = subTopics.removeLast();

    print("[Mqtt App]: recv_data_update bedId:   $patientId $bedId $sectorId");

    int intBedId = int.parse(bedId);
    assert(intBedId is int);

    var content = jsonDecode(contentPayload);
    print("[Mqtt App]: content = $content");

    var now = new DateTime.now();
    now.toUtc();
    final f = new DateFormat.Hms();

    final _platform = Theme.of(contextProvider).platform;

    String formattedDate = _platform == TargetPlatform.iOS
        ? f.format(now)
        : f.format(now.subtract(Duration(hours: 3)));

    BedData data = BedData(
        fc: content['FC'],
        fr: content['FR'],
        so: content['SO'],
        te: content['TE'],
        bedNumber: int.parse(bedId),
        dateDetails: formattedDate,
        sector: sectorId);

    print("[Mqtt App]: Bed Data ${data.sector} bedid = $bedId");

    BedProvider bedProvider =
        Provider.of<BedProvider>(contextProvider, listen: false);

    print("[Mqtt App]: Bed data add map $bedId no ${data.sector}");

    bedProvider.addToSectorMap(bedId, sectorId);
    bedProvider.addToDataList(bedId, data);
  }

  void recv_alarm_cancel(content, subTopics) {
    print("[Mqtt App]: Alarm Cancel");
    print("[Mqtt App]: - content - $content");
    print("[Mqtt App]: - subtopics - $subTopics");
    String bedId = subTopics.removeLast();
    String sectorId = subTopics.removeLast();

    String clinicalStatus = content['CS'].toString();
    String patientId = '';

    _sendMessage(clinicalStatus, patientId, bedId, sectorId, true);
  }

  void recv_alarm_new(contentPayload, subTopics) {
    print("[Mqtt App]: New Alarm");

    String clinicalStatus = subTopics.removeLast();
    String patientId = subTopics.removeLast();
    String bedId = subTopics.removeLast();
    String sectorId = subTopics.removeLast();

    var content = jsonDecode(contentPayload);
    print("[Mqtt App]: content = $content");

    NotificationApi.showNotification(
        title: 'Alerta! Leito $bedId',
        body:
            'FC = ${content['FC']} bpm  FR = ${content['FR']} pm  TE: ${content['TE']} C  SO: ${content['SO']} %',
        payload: 'bed.alert');

    showDialog(
        context: contextNavigation,
        builder: (context) =>
            AlertDialogPatient(clinicalStatus, bedId, content));

    _sendMessage(clinicalStatus, patientId, bedId, sectorId, false);
  }

  void _sendMessage(String clinicalStatus, String patientId, String bedId,
      String sectorId, bool isCancelled) {
    var now = new DateTime.now();
    now.toUtc();

    var diaEMes = DateFormat.yMd();
    String formattedDiaEMes = diaEMes.format(now);

    final f = new DateFormat.Hm();

    final _platform = Theme.of(contextProvider).platform;

    String formattedDateHora = _platform == TargetPlatform.iOS
        ? f.format(now)
        : f.format(now.subtract(Duration(hours: 3)));

    final alert = Alert(clinicalStatus, patientId, bedId, sectorId,
        formattedDiaEMes, formattedDateHora, isCancelled);
   /*  PostgresDao().saveAlert(clinicalStatus, patientId, bedId, sectorId,
        formattedDiaEMes, formattedDateHora, isCancelled); */
  }

  // ignore: non_constant_identifier_names
  void send_alarm_recognition(id) {
    print("[Mqtt App]: Alarm recongnition");
    var nameBed = "bedNumber" + id; // id = numero da cama ou bedId
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
