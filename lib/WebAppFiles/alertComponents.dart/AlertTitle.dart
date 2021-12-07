import 'package:flutter/material.dart';

class AlertTitle extends StatelessWidget {
  final String bedId;
  final String bedSeverityStatus;
  const AlertTitle({
    Key key,
    this.bedId, this.bedSeverityStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Text("LEITO $bedId",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text("$bedSeverityStatus", style: TextStyle(fontSize: 20))
        ],
      ),
    );
  }
}