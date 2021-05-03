import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/Home.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {
        print("Tocou no login"),
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        }))
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