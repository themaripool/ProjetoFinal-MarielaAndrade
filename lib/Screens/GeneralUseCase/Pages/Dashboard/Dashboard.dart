import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/Components/CupertinoPicker.dart';
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
  int value = 0;
  var selectItem;

  final items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
  ];

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    if (status == true) {
      container = GridListView();
    } else if (status == false) {
      container = ListViewPatients();
    }
    if (_platform == TargetPlatform.iOS) {
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
                    CupertinoButton(
                          child: _chosenValue == null
                              ? Text('Selecione o setor')
                              : Text("Setor " + Provider.of<BedProvider>(context, listen: true)
                          .selectedSector),
                          onPressed: () {
                            _show(contextNavigation);
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
    } else {
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
                      value: _chosenValue == null
                          ? _chosenValue = "todos"
                          : _chosenValue,
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

  void _show(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      _chosenValue = 'todos';
                      Provider.of<BedProvider>(context, listen: false)
                          .setSector(_chosenValue);
                      Navigator.of(ctx).pop();
                    },
                    child: Text('todos')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      _chosenValue = 'setor 3';
                      Provider.of<BedProvider>(context, listen: false)
                          .setSector(_chosenValue);
                      Navigator.of(ctx).pop();
                    },
                    child: Text('setor 3')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      _chosenValue = 'setor 4';
                      Provider.of<BedProvider>(context, listen: false)
                          .setSector(_chosenValue);
                      Navigator.of(ctx).pop();
                    },
                    child: Text('setor 4')),
              ],
              cancelButton: CupertinoActionSheetAction(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Close'),
              ),
            ));
  }
}
