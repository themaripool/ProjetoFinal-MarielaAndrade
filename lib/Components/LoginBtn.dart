import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/Home.dart';
import 'package:projeto_final_1/Screens/InpatientPage/HomePatient.dart';

class LoginButton extends StatelessWidget {

  
  const LoginButton({
    Key key,
    @required bool isdoctor,
    @required bool ispatient,
  }) : _isdoctor = isdoctor,
      _ispatient = ispatient,
      super(key: key);

  final bool _ispatient;
  final bool _isdoctor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        if (_isdoctor == true){
          print("Tocou no login"),
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Home();
          }))
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
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.grey[850]),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ))),
    );
  }
}