
/*
  LoginMedicalTeam: Lida com o clique do botão no caso de login do médico
*/

import 'package:flutter/cupertino.dart';
import 'package:projeto_final_1/Data/Data.dart';
import '../../../GeneralUseCase.dart';

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