import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projeto_final_1/Components/BedComponent.dart';

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

    //   Column(children: [
    //     new Text('app'),
    //     new Expanded(
    //         child: new Center(
    //             child: new Container(
    //                 height: [EXPECTED_GRID_HEIGHT],
    //                 child: GridView.count(
    //                   padding: const EdgeInsets.all(20.0),
    //                   crossAxisSpacing: 10.0,
    //                   mainAxisSpacing: 10.0,
    //                   crossAxisCount: 4,
    //                   children: [GRID_ELEMENTS],
    //                 )))),
    //     new Text('app'),
    //   ]),
    // }

    //  ElevatedButton(
    //         onPressed: () {
    //           setState(() {
    //             status = !status;
    //             print(status);
    //           });
    //         },
    //         child: Text(' Disable / Enable')),

    return Scaffold(
        body: Center(
      child: Column(children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                status = !status;
                print(status);
              });
            },
            child: Text(' Disable / Enable')),
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

class _ListViewPatientsState extends State<ListViewPatients> {
  @override
  Widget build(BuildContext context) {
    return Text("Visão em lista");
  }
}
