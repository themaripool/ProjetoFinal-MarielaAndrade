import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/Pages/InpatientData.dart';

// ignore: must_be_immutable
class InpatientDetails extends StatefulWidget {
  List<teste> dataList;

  InpatientDetails({Key key, this.dataList}) : super(key: key);

  @override
  _InpatientDetailsState createState() => _InpatientDetailsState(dataList);
}

class _InpatientDetailsState extends State<InpatientDetails> {
  _InpatientDetailsState(this.dataList);

  List<teste> dataList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://i.pinimg.com/originals/c9/85/9c/c9859c3719f1328d1795df856940ddfd.jpg'),
              radius: 18.0,
            ),
          ],
          backgroundColor: Colors.grey[700],
          title: Text(
            "Bem Vindo John Doe",
            style: TextStyle(color: Colors.grey[350]),
          ),
        ),
        body: ListView.separated(
          itemCount: dataList.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(dataList[index].data),
                Text(dataList[index].valor)
              ],
            );
          },
        ));
  }
}
