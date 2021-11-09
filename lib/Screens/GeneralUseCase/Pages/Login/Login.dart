import 'package:flutter/cupertino.dart';
import 'package:projeto_final_1/Data/Data.dart';
import '../../GeneralUseCase.dart';

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

/*
  initializeFlutterFire: Inicialização do firebase
*/
  /* void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  } */

  @override
  void initState() {
    //initializeFlutterFire();
    NotificationApi.init();
    SymptomsDao().initPostgres();
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
