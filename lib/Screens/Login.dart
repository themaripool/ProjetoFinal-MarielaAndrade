import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_final_1/API/mqttManager.dart';
import 'package:projeto_final_1/Components/TextFieldLogin.dart';
import 'package:projeto_final_1/Screens/InpatientPage/InpatientNavigation.dart';

/*
  TODO:
  [x] Login recebendo inputo do teclado
  [x] Casos de erro caso o input do teclado for errado
  [] Casos input for vazio
  [x] Tirar dependencia do checkbox -> mudar para botao no caso do paciente
*/

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userNameCntl = TextEditingController();
  final TextEditingController _passwordCntl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(children: <Widget>[
          Container(
            child: Column(children: [
              //Header da pagina
              LoginHeader(),
              LoginForm(
                  userNameCntl: _userNameCntl, passwordCntl: _passwordCntl),
            ]),
          ),
        ]),
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 230,
          color: Colors.grey[850],
          child: Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Column(
              children: [
                Text(
                  "Monitoramento",
                  style: TextStyle(color: Colors.white, fontSize: 36),
                ),
                Text("COVID",
                    style: TextStyle(color: Colors.white, fontSize: 36)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
    @required TextEditingController userNameCntl,
    @required TextEditingController passwordCntl,
  })  : _userNameCntl = userNameCntl,
        _passwordCntl = passwordCntl,
        super(key: key);

  final TextEditingController _userNameCntl;
  final TextEditingController _passwordCntl;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var isPatient = false;
  var isDoctor = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: TextFieldLogin(
                controller: widget._userNameCntl,
                keyboard: TextInputType.emailAddress,
                obscureText: false,
                icon: Icon(Icons.person),
                labelText: "Login"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: TextFieldLogin(
              controller: widget._passwordCntl,
              keyboard: TextInputType.number,
              obscureText: true,
              icon: Icon(Icons.lock),
              labelText: "Password",
            ),
          ),
          ElevatedButton(
            onPressed: () => {
              MQTTManager().initializeMQTTClient(widget._userNameCntl.text, widget._passwordCntl.text, context),
              MQTTManager().connect(),
            },
            child: Text("Login"),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey[850]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ))),
          ),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomePatient();
              }))
            },
            child: Text("Login Paciente"),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.grey[850]),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ))),
          )
        ],
      ),
    );
  }
}
