import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

MqttClient createClientWithPort(
        String server, String clientIdentifier, int port, int wsPort) =>
    MqttBrowserClient.withPort(server, clientIdentifier, wsPort ?? port);
