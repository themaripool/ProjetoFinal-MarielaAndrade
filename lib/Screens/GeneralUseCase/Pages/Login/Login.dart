import 'package:flutter/cupertino.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/WebAppFiles/detailsWeb.dart';
import 'package:projeto_final_1/WebAppFiles/loginWeb.dart';
import 'package:projeto_final_1/WebAppFiles/mainWeb.dart';
import '../../GeneralUseCase.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userNameCntl = TextEditingController();
  final TextEditingController _passwordCntl = TextEditingController();

  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    NotificationApi.init();
    _initialized = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    if (!_initialized) {
      if (_platform == TargetPlatform.iOS) {
        return Center(child: CupertinoActivityIndicator());
      } else {
        return Center(child: CircularProgressIndicator());
      }
    } else {
      if (_platform == TargetPlatform.iOS ||
          _platform == TargetPlatform.android) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Stack(children: <Widget>[
              Container(
                child: Column(children: [
                  LoginHeader(),
                  _platform == TargetPlatform.iOS
                      ? LoginFormCupertino(
                          passwordCntl: _passwordCntl,
                          userNameCntl: _userNameCntl)
                      : LoginFormMaterial(
                          userNameCntl: _userNameCntl,
                          passwordCntl: _passwordCntl),
                  LoginMedicalTeam(
                    passwordCntl: _passwordCntl,
                    userNameCntl: _userNameCntl,
                  )
                ]),
              ),
            ]),
          ),
        );
      } else {
        return SignUpWebApp();
      }
    }
  }
}
