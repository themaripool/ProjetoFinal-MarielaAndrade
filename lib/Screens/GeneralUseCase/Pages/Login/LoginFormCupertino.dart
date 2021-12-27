
/*
  LoginFormCupertino: Textfields do tipo cupertino
*/

import 'package:flutter/cupertino.dart';

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
                obscureText: true,
                placeholder: "Password"),
          ),
        ],
      ),
    );
  }
}