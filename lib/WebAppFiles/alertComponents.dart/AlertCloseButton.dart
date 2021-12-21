import 'package:flutter/material.dart';

/* ==================================================
  Botão de fechar do alerta
===================================================== */

class AlertCloseButton extends StatelessWidget {
  const AlertCloseButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(
            Icons.close,
          ),
          iconSize: 24,
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}