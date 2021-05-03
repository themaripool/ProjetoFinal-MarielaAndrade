

import 'package:flutter/material.dart';

class TextFieldLogin extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboard;
  final bool obscureText;
  final Icon icon;
  final String labelText;

  TextFieldLogin(
      {this.controller,
      this.keyboard,
      this.obscureText,
      this.icon,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: obscureText,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
        keyboardType: keyboard,
        decoration: InputDecoration(
            prefixIcon: icon,
            labelText: labelText,
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(40.0),
              ),
            )));
  }
}
