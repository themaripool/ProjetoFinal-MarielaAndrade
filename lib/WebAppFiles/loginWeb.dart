import 'package:flutter/material.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';

class SignUpWebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => LoginWeb(),
      },
    );
  }
}

class LoginWeb extends StatefulWidget {
  LoginWeb({this.title});
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginWeb> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.grey[850],
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      "Monitoramento",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                    Text("COVID",
                        style: TextStyle(color: Colors.white, fontSize: 50)),
                    Spacer()
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                color: Colors.grey[300],
                child: Center(
                  child: Card(
                    color: Colors.grey[350],
                    child: Container(
                      padding: EdgeInsets.all(42),
                      width: MediaQuery.of(context).size.width / 3.6,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          Image.asset("assets/images/iconLogin.png", width: 50, height: 50,),
                          SizedBox(height: 24.0),
                          Stack(
                              fit: StackFit.loose,
                              clipBehavior: Clip.none,
                              children: [
                                _loginScreen(context),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Container _loginScreen(BuildContext context) {
    final _usernameTextController = TextEditingController();
    final _passwordTextController = TextEditingController();
    final _hostTextController = TextEditingController();
    final _appIdTextController = TextEditingController();
    return Container(
      width: double.infinity,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _usernameTextController,
              decoration: InputDecoration(hintText: 'Usuario'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _passwordTextController,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Senha'),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _appIdTextController,
              decoration: InputDecoration(hintText: 'AppId'),
            ),
            SizedBox(height: 24.0),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.disabled)
                      ? null
                      : Colors.grey[850];
                }),
              ),
              onPressed: () {
                MQTTManagerWeb().initializeMQTTClient(
                    _usernameTextController.text,
                    _passwordTextController.text,
                    _appIdTextController.text,
                    context);
                MQTTManagerWeb().connect();
              },
              child: Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }
}