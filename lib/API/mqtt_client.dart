//https://github.com/shamblett/mqtt_client/blob/master/example/mqtt_server_client_websocket.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:projeto_final_1/API/BedDataList.dart';
import 'package:provider/provider.dart';
import 'dart:typed_data';
import 'package:typed_data/typed_data.dart';

String broker = 'ws://192.168.0.4';
int port = 9001;
String clientIdentifier = 'SmartAlarm';

String username; //= 'teste';
String passwd; //= '123';
String appId = "teste1";

BuildContext contextProvider;

//var Beds = [];
var Beds = List(2);

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

final client = MqttServerClient.withPort(broker, clientIdentifier, port);

Future<int> mainTest1(context, login, password) async {
  username = login;
  passwd = password;

  contextProvider = context;
  client.useWebSocket = true;
  client.port = port;
  client.logging(on: false);
  client.keepAlivePeriod = 20;

  client.onDisconnected = onDisconnected;
  client.onConnected = onConnected;
  client.onSubscribed = onSubscribed;
  client.pongCallback = pong;
  client.onUnsubscribed = onUnsubscribed;

  final connMess = MqttConnectMessage()
      .withClientIdentifier(appId)
      .keepAliveFor(60)
      .withWillTopic('willtopic')
      .withWillMessage('My Will message')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);

  print('EXAMPLE::Mosquitto client connecting....');

  client.connectionMessage = connMess;

  try {
    await client.connect();
  } on NoConnectionException catch (e) {
    print('EXAMPLE::client exception - $e');
    client.disconnect();
  } on SocketException catch (e) {
    print('EXAMPLE::socket exception - $e');
    client.disconnect();
  }

  if (client.connectionStatus.state == MqttConnectionState.connected) {
    print('EXAMPLE::Mosquitto client connected');
  } else {
    print(
        'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
    exit(-1);
  }

  print(
      'EXAMPLE::Subscribing to the SmartAlarm/Client/Application/Login/teste1 topic');

  client.subscribe(clientLoginTopic, MqttQos.atLeastOnce);

  Map<String, dynamic> str = {
    'CD': '1',
    'DT': '1632084398',
    'UN': 'teste',
    'PW': '123'
  };

  String json = jsonEncode(str);
  Uint8List data = utf8.encode(json);
  Uint8Buffer dataBuffer = Uint8Buffer();
  dataBuffer.addAll(data);

  client.publishMessage(serverLoginTopic, MqttQos.atLeastOnce, dataBuffer);

  client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    final recMess = c[0].payload as MqttPublishMessage;
    final contentPayload =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    print(
        'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $contentPayload -->}');

    if (c[0].topic == clientLoginTopic) {
      var content = jsonDecode(contentPayload);
      print("content = $content");

      var cd = content['CD'];

      if (cd == "2") {
        login_accepted();
      }
    } else if (c[0].topic ==
        "SmartAlarm/Client/Application/InitialData/teste1") {
      receive_InitialData(contentPayload);
    } else {
      var subTopics = c[0].topic.split("/");

      if (c[0].topic.contains(TOPIC_200)) {
        print("-------------- contem topico 200 --------------");
        receive_data(contentPayload, subTopics);
      }
    }
  });
  //fim listen

  client.published.listen((MqttPublishMessage message) {
    print(
        'EXAMPLE::Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
  });

  /// Lets publish to our topic
  /// Use the payload builder rather than a raw buffer
  /// Our known topic to publish to
  /* const pubTopic = "SmartAlarm/Client/Application/Login/teste1";
  final builder = MqttClientPayloadBuilder();
  builder.addString('Hello from mqtt_client');

  /// Subscribe to it
  print('EXAMPLE::Subscribing to the Dart/Mqtt_client/testtopic topic');
  client.subscribe(pubTopic, MqttQos.exactlyOnce); */

  /// Publish it
  /* print('EXAMPLE::Publishing our topic');
  client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload); */

  /*  print('EXAMPLE::Sleeping....');
  await MqttUtilities.asyncSleep(120); */

  /* print('EXAMPLE::Unsubscribing');
  client.unsubscribe(topic); */

  /*  await MqttUtilities.asyncSleep(2);
  print('EXAMPLE::Disconnecting');
  client.disconnect(); */
  return 0;
}

void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
}

void onUnsubscribed(String topic) {
  print('EXAMPLE::Unsubscribed confirmed for topic $topic');
}

void onDisconnected() {
  print('EXAMPLE::OnDisconnected client callback - Client disconnection');
  if (client.connectionStatus.disconnectionOrigin ==
      MqttDisconnectionOrigin.solicited) {
    print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
  }
  exit(-1);
}

void onConnected() {
  print(
      'EXAMPLE::OnConnected client callback - Client connection was sucessful');
}

void pong() {
  print('EXAMPLE::Ping response client callback invoked');
}

/*------------------------------------------------------------------------
FUNCOES AUXILIARES PARA LIDAR COM AS MENSAGENS DO MQTT
-------------------------------------------------------------------------*/

void login_accepted() {
  print("------------------------ LOGIN ACEITO --------------------------");

  client.subscribe(clientInitialData, MqttQos.atLeastOnce);
  client.unsubscribe(clientLoginTopic);

  Map<String, dynamic> str = {'UI': 2, 'SI': 3};

  String json = jsonEncode(str);

  Uint8List data = utf8.encode(json);
  Uint8Buffer dataBuffer = Uint8Buffer();
  dataBuffer.addAll(data);

  client.publishMessage(serverInitialData, MqttQos.atLeastOnce, dataBuffer);
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

    client.subscribe(sectorData, MqttQos.atLeastOnce);
    client.subscribe(alarmIssued, MqttQos.atLeastOnce);
    client.subscribe(alarmRecognized, MqttQos.atLeastOnce);
    client.subscribe(alarmCancelled, MqttQos.atLeastOnce);
  }
  client.subscribe(appHistory, MqttQos.atLeastOnce);
  client.unsubscribe(serverInitialData);
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

  if (bedId == "4") {
    print("Entrou no if");
    BedData data1 = BedData(
        fc: content['FC'],
        fr: content['FR'],
        so: content['SO'],
        te: content['TE'],
        bedNumber: 4);

    BedProvider bedProvider =
        Provider.of<BedProvider>(contextProvider, listen: false);
    var index = bedProvider.searchBedNumberInList(data1.bedNumber);
    if (index != -1) {
      bedProvider.removeBedInfo(index);
      bedProvider.addBedAtIndex(index, data1);
    } else {
      bedProvider.addBedInfo(data1);
    }
  }

  if (bedId == "5") {
    print("Entrou no if - 5");
    BedData data1 = BedData(
        fc: content['FC'],
        fr: content['FR'],
        so: content['SO'],
        te: content['TE'],
        bedNumber: 5);

    BedProvider bedProvider =
        Provider.of<BedProvider>(contextProvider, listen: false);
    var index = bedProvider.searchBedNumberInList(data1.bedNumber);
    if (index != -1) {
      bedProvider.removeBedInfo(index);
      bedProvider.addBedAtIndex(index, data1);
    } else {
      bedProvider.addBedInfo(data1);
    }
  }

  /*  if (bedId == "4") {
// Clinical Status count
    Beds[0] = content['CS'];
  } else {
// Clinical Status count
    Beds[1] = content['CS'];
  } */
}
