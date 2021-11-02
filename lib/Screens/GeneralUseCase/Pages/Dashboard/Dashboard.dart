import 'package:flutter/rendering.dart';
import '../../GeneralUseCase.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var status = true;
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
            Expanded(child: Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Center(child: container),
            )),
          ]),
        ));
  }
}

