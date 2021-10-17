import 'package:flutter/material.dart';
import 'package:projeto_final_1/API/BedDataList.dart';

class HomeCard extends StatelessWidget {
  final int index;
  final BedDataDetails bedInfo;
  final Function updateCallback;
  final Function deleteCallback;

  HomeCard({
    this.index,
    this.bedInfo,
    this.updateCallback,
    this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[500],
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FR = ${bedInfo.fr}'),
                SizedBox(height: 2),
                Text('Fc = ${bedInfo.fc}'),
                SizedBox(height: 2),
                Text('SO = ${bedInfo.so}'),
                SizedBox(height: 2),
                Text('TE = ${bedInfo.te}'),
                SizedBox(height: 2),
                Text('DEBUG - Numero da cama = ${bedInfo.bedNumber}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
