import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projeto_final_1/Components/BedComponent.dart';
import 'package:projeto_final_1/Components/BedComponentList.dart';

var componentes = [
  BedComponent(
      "LEITO 1", Colors.yellow, Color.fromRGBO(230, 178, 47, 1.0), "SEVERO"),
  BedComponent("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
  BedComponent("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
  BedComponent("LEITO 4", Colors.red, Colors.red, "CRÍTICO"),
  BedComponent("LEITO 1", Colors.yellow, Colors.yellow, "SEVERO"),
  BedComponent("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
  BedComponent("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
  BedComponent("LEITO 4", Colors.red, Colors.red, "CRÍTICO"),
  BedComponent("LEITO 1", Colors.yellow, Colors.yellow, "SEVERO"),
  BedComponent("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
  BedComponent("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
  BedComponent("LEITO 4", Colors.red, Colors.red, "CRÍTICO"),
  BedComponent("LEITO 1", Colors.yellow, Colors.yellow, "SEVERO"),
  BedComponent("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
  BedComponent("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
  BedComponent("LEITO 4", Colors.red, Colors.red, "CRÍTICO")
];

var componentesLista = [
  BedComponentList(
      "LEITO 1", Colors.yellow, Color.fromRGBO(230, 178, 47, 1.0), "SEVERO"),
  BedComponentList("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
  BedComponentList("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
  BedComponentList("LEITO 4", Colors.red, Colors.red, "CRÍTICO"),
  BedComponentList("LEITO 1", Colors.yellow, Colors.yellow, "SEVERO"),
  BedComponentList("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
  BedComponentList("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
  BedComponentList("LEITO 4", Colors.red, Colors.red, "CRÍTICO"),
  BedComponentList("LEITO 1", Colors.yellow, Colors.yellow, "SEVERO"),
  BedComponentList("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
  BedComponentList("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
  BedComponentList("LEITO 4", Colors.red, Colors.red, "CRÍTICO"),
  BedComponentList("LEITO 1", Colors.yellow, Colors.yellow, "SEVERO"),
  BedComponentList("LEITO 2", Colors.blue, Colors.blue, "PREOCUPANTE"),
  BedComponentList("LEITO 3", Colors.green, Colors.green, "ESTÁVEL"),
  BedComponentList("LEITO 4", Colors.red, Colors.red, "CRÍTICO")
];

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
                        print('Received click');
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
            Expanded(child: Center(child: container)),
          ]),
        ));
  }
}

class GridListView extends StatefulWidget {
  GridListView({Key key}) : super(key: key);

  @override
  _GridListViewState createState() => _GridListViewState();
}

class _GridListViewState extends State<GridListView> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 2.0,
        childAspectRatio: (130 / 177),
        children: List.generate(componentes.length, (index) {
          return Center(child: componentes[index]);
        }));
  }
}

class ListViewPatients extends StatefulWidget {
  ListViewPatients({Key key}) : super(key: key);

  @override
  _ListViewPatientsState createState() => _ListViewPatientsState();
}

//componentesLista

class _ListViewPatientsState extends State<ListViewPatients> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: componentesLista.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        color: Colors.black,
      ),
      itemBuilder: (BuildContext context, int index) {
        return componentesLista[index];
      },
    );
  }
}
