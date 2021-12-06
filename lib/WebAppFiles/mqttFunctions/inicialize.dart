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