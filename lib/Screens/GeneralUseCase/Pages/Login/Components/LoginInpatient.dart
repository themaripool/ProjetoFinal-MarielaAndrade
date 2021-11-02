/*
  LoginInpatient: Lida com o clique do botão no caso de login do paciente
*/

import 'package:flutter/cupertino.dart';
import 'package:projeto_final_1/Data/Data.dart';
import '../../../GeneralUseCase.dart';

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