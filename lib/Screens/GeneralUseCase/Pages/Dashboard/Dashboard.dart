import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projeto_final_1/Data/Data.dart';
import '../../GeneralUseCase.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var status = true;
  String _chosenValue;
  var container;

  @override
  Widget build(BuildContext context) {
    if (status == true) {
      container = GridListView();
    } else if (status == false) {
      container = ListViewPatients();
    }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                        width: 1.5,
                        color: Colors.black,
                      )),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DashboardAlarmView();
                        }));
                      },
                      child: const Text(
                        'Alarmes',
                        style: TextStyle(color: Colors.black),
                      )),
                  Spacer(),
                  DropdownButton<String>(
                    focusColor: Colors.white,
                    value: _chosenValue,
                    //elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'todos',
                      'setor 3',
                      'setor 4',
                      'setor 5',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Selecione o setor",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _chosenValue = value;
                        Provider.of<BedProvider>(context, listen: false)
                            .setSector(_chosenValue);
                      });
                    },
                  ),
                  Spacer(),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: status == true
                              ? Colors.grey[850]
                              : Colors.transparent,
                          side: BorderSide(
                            width: 1.5,
                            color: Colors.black,
                          )),
                      onPressed: () {
                        setState(() {
                          status = true;
                          print(status);
                        });
                      },
                      child: Icon(
                        Icons.grid_on,
                        color: status == false ? Colors.black : Colors.white,
                      )),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          backgroundColor: status == false
                              ? Colors.grey[850]
                              : Colors.transparent,
                          side: BorderSide(
                            width: 1.5,
                            color: Colors.black,
                          )),
                      onPressed: () {
                        setState(() {
                          status = false;
                          print(status);
                        });
                      },
                      child: Icon(
                        Icons.list,
                        color: status == false ? Colors.white : Colors.black,
                      )),
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Center(child: container),
            )),
          ]),
        ));
  }
}
