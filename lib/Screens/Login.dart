import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projeto_final_1/Components/LoginBtn.dart';
import 'package:projeto_final_1/Components/TextFieldLogin.dart';

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
      resizeToAvoidBottomPadding: false,
      body: Stack(children: <Widget>[
        Container(
          child: Column(children: [
            //Header da pagina
            LoginHeader(),
            LoginForm(userNameCntl: _userNameCntl, passwordCntl: _passwordCntl),
          ]),
        ),
      ]),
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
                    style:
                        TextStyle(color: Colors.white, fontSize: 36)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
    @required TextEditingController userNameCntl,
    @required TextEditingController passwordCntl,
  }) : _userNameCntl = userNameCntl, _passwordCntl = passwordCntl, super(key: key);

  final TextEditingController _userNameCntl;
  final TextEditingController _passwordCntl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: TextFieldLogin(
                controller: _userNameCntl,
                keyboard: TextInputType.emailAddress,
                obscureText: false,
                icon: Icon(Icons.person),
                labelText: "Login"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: TextFieldLogin(
              controller: _passwordCntl,
              keyboard: TextInputType.number,
              obscureText: true,
              icon: Icon(Icons.lock),
              labelText: "Password",
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 72),
            child: SizedBox(
              width: 350.0,
              height: 50.0,
              child: LoginButton(),
            ),
          )
        ],
      ),
    );
  }
}
