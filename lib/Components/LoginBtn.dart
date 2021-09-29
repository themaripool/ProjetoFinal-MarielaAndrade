import 'package:flutter/material.dart';
import 'package:projeto_final_1/API/mqttManager.dart';
import 'package:projeto_final_1/API/mqttManager.dart';
import 'package:projeto_final_1/API/mqtt_client.dart';
import 'package:projeto_final_1/Screens/Home.dart';
import 'package:projeto_final_1/Screens/InpatientPage/InpatientNavigation.dart';

/*
  TODO:
  [x] Login recebendo inputo do teclado
  [] Casos de erro caso o input do teclado for errado
  [] Casos input for vazio
  [] Tirar dependencia do checkbox -> mudar para botao no caso do paciente
*/

class LoginButton extends StatelessWidget {
  final bool _ispatient;
  final bool _isdoctor;
  final String login;
  final String password;

  const LoginButton({
    Key key,
    bool isdoctor,
    bool ispatient,
    this.login,
    this.password,
  })  : _isdoctor = isdoctor,
        _ispatient = ispatient,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    MQTTManager manager;
    return ElevatedButton(
      onPressed: () => {
        if (_isdoctor == true)
          {
            print("Tocou no login"),
            /*  if (login.isEmpty) {login = "teste"},
            if (password.isEmpty) {password = "123"}, */
            //mainTest1(context, login, password),
            MQTTManager().initializeMQTTClient(login, password, context),
            MQTTManager().connect(),
            print(MQTTManager().contentLoginRequest),
          }
        else if (_ispatient == true){
          
          print("Tocou no login - caso paciente"),

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return HomePatient();
          }))
          
        }
      },
      child: Text("Login"),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey[850]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ))),
    );
  }
}
