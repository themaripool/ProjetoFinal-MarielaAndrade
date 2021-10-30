import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';
import '../GeneralUseCase.dart';

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

  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    NotificationApi.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    print("[DEBUG]: AAAAAA - $_platform ");
    if (!_initialized) {
      return CircularProgressIndicator();
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Container(
              child: Column(children: [
                //Header da pagina
                LoginHeader(),
                _platform == TargetPlatform.iOS
                    ? LoginFormCupertino(
                        passwordCntl: _passwordCntl,
                        userNameCntl: _userNameCntl,
                      )
                    : LoginForm(
                        userNameCntl: _userNameCntl,
                        passwordCntl: _passwordCntl),
                LoginInpatient(
                  passwordCntl: _passwordCntl, 
                  userNameCntl: _userNameCntl,
                ),
                LoginMedicalTeam(
                  passwordCntl: _passwordCntl,
                  userNameCntl: _userNameCntl,
                )
              ]),
            ),
          ]),
        ),
      );
    }
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
        ],
      ),
    );
  }
}

class LoginFormCupertino extends StatefulWidget {
  const LoginFormCupertino({
    Key key,
    @required TextEditingController userNameCntl,
    @required TextEditingController passwordCntl,
  })  : _userNameCntl = userNameCntl,
        _passwordCntl = passwordCntl,
        super(key: key);

  final TextEditingController _userNameCntl;
  final TextEditingController _passwordCntl;

  @override
  _LoginCupertinoFormState createState() => _LoginCupertinoFormState();
}

class _LoginCupertinoFormState extends State<LoginFormCupertino> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: CupertinoTextField(
                controller: widget._userNameCntl,
                keyboardType: TextInputType.emailAddress,
                placeholder: "Login"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: CupertinoTextField(
                controller: widget._passwordCntl,
                keyboardType: TextInputType.number,
                placeholder: "Password"),
          ),
        ],
      ),
    );
  }
}

class LoginInpatient extends StatelessWidget {
  const LoginInpatient({
    Key key,
    @required TextEditingController userNameCntl,
    @required TextEditingController passwordCntl,
  })  : _userNameCntl = userNameCntl,
        _passwordCntl = passwordCntl,
        super(key: key);

  final TextEditingController _userNameCntl;
  final TextEditingController _passwordCntl;

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    if (_platform == TargetPlatform.iOS) {
      return CupertinoButton(
        child: Text("Login Paciente"),
        color: CupertinoColors.systemGrey,
        onPressed: () => {
          MQTTManager().initializeMQTTClient(
              _userNameCntl.text, _passwordCntl.text, context),
          MQTTManager().connect(),
        },
      );
    } else {
      return ElevatedButton(
        onPressed: () => {
          MQTTManager().initializeMQTTClient(
              _userNameCntl.text, _passwordCntl.text, context),
          MQTTManager().connect(),
        },
        child: Text("Login Paciente"),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[850]),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ))),
      );
    }
  }
}

class LoginMedicalTeam extends StatelessWidget {
  const LoginMedicalTeam({
    Key key,
    @required TextEditingController userNameCntl,
    @required TextEditingController passwordCntl,
  })  : _userNameCntl = userNameCntl,
        _passwordCntl = passwordCntl,
        super(key: key);

  final TextEditingController _userNameCntl;
  final TextEditingController _passwordCntl;

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    if (_platform == TargetPlatform.iOS) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: CupertinoButton(
          child: Text("Login Médico"),
          color: CupertinoColors.systemGrey,
          onPressed: () {
            MQTTManager().initializeMQTTClient(
                _userNameCntl.text, _passwordCntl.text, context);
            MQTTManager().connect();
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ElevatedButton(
          onPressed: () => {
            MQTTManager().initializeMQTTClient(
                _userNameCntl.text, _passwordCntl.text, context),
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
      );
    }
  }
}
