import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

MqttClient createClientWithPort(
        String server, String clientIdentifier, int port, int wsPort) =>
    MqttServerClient.withPort(server, clientIdentifier, port);
