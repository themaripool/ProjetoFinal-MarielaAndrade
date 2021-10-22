import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:projeto_final_1/API/BedDataList.dart';
import 'package:projeto_final_1/Components/AlertDialogPatient.dart';
import 'package:projeto_final_1/Components/ErrorLoginAlertDialog.dart';
import 'package:projeto_final_1/Data/alarmsDAO.dart';
import 'package:projeto_final_1/Data/alarms.dart';
import 'package:projeto_final_1/Screens/Home.dart';
import 'package:provider/provider.dart';
import 'package:typed_data/typed_data.dart';

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

var clientInitialData =
    TOPIC_602 + appId; //"SmartAlarm/Client/Application/InitialData/teste1"
var serverInitialData =
    TOPIC_402 + appId; //"SmartAlarm/Server/Application/InitialData/teste1"
var clientLoginTopic =
    TOPIC_601 + appId; //"SmartAlarm/Client/Application/Login/teste1";
var serverLoginTopic =
    TOPIC_401 + appId; //"SmartAlarm/Server/Application/Login/teste1"
var sectorData = TOPIC_200 + '3' + '/#'; //SmartAlarm/Data/SectorId/3/#
var alarmIssued = TOPIC_301 + '3' + '/#'; //"SmartAlarm/Alarms/Issued"/3/#
var alarmRecognized = TOPIC_302 + '3' + '/#'; //"SmartAlarm/Alarms/Recognized"
var alarmCancelled = TOPIC_303 + '3' + '/#'; //"SmartAlarm/Alarms/Cancelled";
var appHistory = TOPIC_604 + '2'; //"SmartAlarm/Client/Application/History"

/* ==================================================
GLOBAIS
===================================================== */

String broker = 'ws://192.168.5.178';
int port = 9001;
String clientIdentifier = 'SmartAlarm';

String username; //= 'teste';
String passwd; //= '123';
String appId = "teste1";

BuildContext contextProvider;
BuildContext contextNavigation;

var Beds = List(2);
final _client = MqttServerClient.withPort(broker, clientIdentifier, port);

AlarmsDao alarmsDao;

// ====================================================

class MQTTManager {
  var contentLoginRequest;
  void initializeMQTTClient(login, password, BuildContext context) {
    alarmsDao = AlarmsDao();

    username = login;
    passwd = password;

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

    print('EXAMPLE::Mosquitto client connecting....');
    _client.connectionMessage = connMess;
  }

  // Connect to the host
  // ignore: avoid_void_async
  void connect() async {
    assert(_client != null);
    try {
      await _client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      disconnect();
    }
  }

  void disconnect() {
    print('Disconnected');
    _client.disconnect();
  }

  /// The subscribed callback
  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    print(
        ' -- return code ${_client.connectionStatus.returnCode} mqtt ${MqttConnectReturnCode.noneSpecified}');
    if (_client.connectionStatus.returnCode ==
        MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
  }

  /// The successful connect callback
  void onConnected() {
    print('EXAMPLE::Mosquitto client connected....');
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
        print("content = $content");

        contentLoginRequest = content['CD'];

        if (contentLoginRequest == "2") {
          login_accepted();
          Navigator.push(contextNavigation,
              MaterialPageRoute(builder: (contextNavigation) {
            return Home();
          }));
        } else if (contentLoginRequest != "2") {
          _client.disconnect();
          showErrorLoginAlertDialog(contextNavigation);
        }
      } else if (c[0].topic == clientInitialData) {
        receive_InitialData(contentPayload);
      } else {
        print("---- ENTROU ELSE COM TOPICO ${c[0].topic} -----");
        var subTopics = c[0].topic.split("/");

        if (c[0].topic.contains(TOPIC_200)) {
          receive_data(contentPayload, subTopics);
        } else if (c[0].topic.contains(TOPIC_301)) {
          print("---- CHAMOU ALARME -----");
          recv_alarm_new(contentPayload, subTopics);
        } else if (c[0].topic.contains(TOPIC_302)) {
          print("---- RECONHECEU ALARME -----");
        } else if (c[0].topic.contains(TOPIC_303)) {
          print("---- CANCELOU ALARME -----");
          recv_alarm_cancel(contentPayload, subTopics);
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
    print('EXAMPLE::Subscribing to ...Application/Login/teste1 topic');

    _client.subscribe(clientLoginTopic, MqttQos.atLeastOnce);

    Map<String, dynamic> str = {
      'CD': '1',
      'DT': '1632084368',
      'UN': '$username',
      'PW': '$passwd'
    };

    String json = jsonEncode(str);
    Uint8List data = utf8.encode(json);
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    print('EXAMPLE::publishMessage ...$str');
    _client.publishMessage(serverLoginTopic, MqttQos.atLeastOnce, dataBuffer);
  }

  void login_accepted() {
    print("------------------------ LOGIN ACEITO --------------------------");

    _client.subscribe(clientInitialData, MqttQos.atLeastOnce);
    _client.unsubscribe(clientLoginTopic);

    Map<String, dynamic> str = {'UI': 2, 'SI': 3};

    String json = jsonEncode(str);

    Uint8List data = utf8.encode(json);
    Uint8Buffer dataBuffer = Uint8Buffer();
    dataBuffer.addAll(data);

    _client.publishMessage(serverInitialData, MqttQos.atLeastOnce, dataBuffer);
  }

// ignore: non_constant_identifier_names
  void receive_InitialData(pt) {
    var content = jsonDecode(pt);

    print("content = $content");

    var l_bedNums = content['BN'];

    if (l_bedNums.contains(";")) {
      l_bedNums = l_bedNums.split(';');
    } else {
      l_bedNums = [l_bedNums];
    }

    var SECTOR_NUMBEDS = {};
    for (var i = 0; i < l_bedNums.length; i++) {
      var tmp = l_bedNums[i].split(",");
      SECTOR_NUMBEDS[tmp[0]] = tmp[1];

      _client.subscribe(sectorData, MqttQos.atLeastOnce);
      _client.subscribe(alarmIssued, MqttQos.atLeastOnce);
      _client.subscribe(alarmRecognized, MqttQos.atLeastOnce);
      _client.subscribe(alarmCancelled, MqttQos.atLeastOnce);
    }
    _client.subscribe(appHistory, MqttQos.atLeastOnce);
    _client.unsubscribe(serverInitialData);
  }

  void receive_data(contentPayload, subTopics) {
    print("------------------------ RECEIVE DATA --------------------------");

    print("subtopics = $subTopics");

    // subTopics[..., Sector, Bed, Patient]
    String patientId = subTopics.removeLast();
    String bedId = subTopics
        .removeLast(); // id da cama ta vindo como 4 ou 5, de acordo com a cmaa ele salva o payl
    String sectorId = subTopics.removeLast();

    print("recv_data_update bedId:   $patientId $bedId $sectorId");

    int intBedId = int.parse(bedId);
    assert(intBedId is int);

    var content = jsonDecode(contentPayload);
    print("content = $content");

    var now = new DateTime.now();
    now.toUtc();
    final f = new DateFormat.Hms();
    String formattedDate = f.format(now);

    print("[DEBUG]: $formattedDate");

    BedDataDetails data = BedDataDetails(
        fc: content['FC'],
        fr: content['FR'],
        so: content['SO'],
        te: content['TE'],
        bedNumber: int.parse(bedId),
        dateDetails: formattedDate);

    BedProvider bedProvider =
        Provider.of<BedProvider>(contextProvider, listen: false);

    bedProvider.addToDataList(bedId, data);
  }

  void recv_alarm_cancel(content, subTopics) {
    print(
        "------------------------ ALARM CANCELLED --------------------------");
    print("aaaa - content - $content");
    print("aaaa - subtopics - $subTopics");
    String bedId = subTopics.removeLast();
    String sectorId = subTopics.removeLast();

    String clinicalStatus = content['CS'];
    String patientId = '';

    _sendMessage(clinicalStatus, patientId, bedId, sectorId, true);
  }

  void recv_alarm_new(contentPayload, subTopics) {
    print("------------------------ ALARM NEW --------------------------");

    String clinicalStatus = subTopics.removeLast();
    String patientId = subTopics.removeLast();
    String bedId = subTopics.removeLast();
    String sectorId = subTopics.removeLast();

    print(
        "clinicalStatus $clinicalStatus, patientId $patientId, bedId $bedId, sectorId $sectorId ");

    var content = jsonDecode(contentPayload);
    print("content = $content");

    showDialog(
        context: contextNavigation,
        builder: (context) => AlertDialogPatient(bedId, content));

    _sendMessage(clinicalStatus, patientId, bedId, sectorId, false);
  }

  void _sendMessage(String clinicalStatus, String patientId, String bedId,
      String sectorId, bool isCancelled) {
    var now = new DateTime.now();
    now.toUtc();

    var diaEMes = DateFormat.yMd();
    String formattedDiaEMes = diaEMes.format(now);

    final f = new DateFormat.Hm();
    String formattedDateHora = f.format(now);

    final alert = AlertModel(clinicalStatus, patientId, bedId, sectorId,
        formattedDiaEMes, formattedDateHora, isCancelled);
    alarmsDao.saveMessage(alert);
  }

  // ignore: non_constant_identifier_names
  void send_alarm_recognition(id) {
    print("------------------------ ALARM RECON --------------------------");
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

    print("-------- topic aaaaa $RECOGNIZED_TOPIC e $alarmRecognized");

    _client.publishMessage(RECOGNIZED_TOPIC, MqttQos.atLeastOnce, dataBuffer);
  }
}
