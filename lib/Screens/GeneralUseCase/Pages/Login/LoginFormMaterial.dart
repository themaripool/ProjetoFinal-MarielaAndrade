
/*
  LoginForm: Textfields do tipo material
*/

import '../../GeneralUseCase.dart';

class LoginFormMaterial extends StatefulWidget {
  const LoginFormMaterial({
    Key key,
    @required TextEditingController userNameCntl,
    @required TextEditingController passwordCntl,
  })  : _userNameCntl = userNameCntl,
        _passwordCntl = passwordCntl,
        super(key: key);

  final TextEditingController _userNameCntl;
  final TextEditingController _passwordCntl;

  @override
  _LoginFormMaterialState createState() => _LoginFormMaterialState();
}

class _LoginFormMaterialState extends State<LoginFormMaterial> {
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