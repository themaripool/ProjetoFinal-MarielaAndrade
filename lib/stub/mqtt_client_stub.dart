import 'package:mqtt_client/mqtt_client.dart';

MqttClient createClientWithPort(
        String server, String clientIdentifier, int port, int wsPort) =>
    throw UnsupportedError(
        'Cannot create a client without dart:html or dart:io.');
