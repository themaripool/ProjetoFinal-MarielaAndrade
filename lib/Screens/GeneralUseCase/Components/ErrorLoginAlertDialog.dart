/*
  showErrorLoginAlertDialog: Dialog de erro de login de acordo com o so
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showErrorLoginAlertDialog(BuildContext context) {
  final _platform = Theme.of(context).platform;

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Erro no login"),
    content: Text("Por favor tente novamente"),
    actions: [
      okButton,
    ],
  );

  CupertinoAlertDialog alertIos = CupertinoAlertDialog(
  title: new Text("Erro no login"),
  content: new Text("Por favor tente novamente"),
  actions: <Widget>[
    CupertinoDialogAction(
      isDefaultAction: true,
      child: Text("Ok"),
      onPressed: (){
        Navigator.pop(context);
      }
    ),
  ],
);

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      if (_platform == TargetPlatform.iOS) {
        return alertIos;
      }else {
        return alert;
      }
    },
  );
}
