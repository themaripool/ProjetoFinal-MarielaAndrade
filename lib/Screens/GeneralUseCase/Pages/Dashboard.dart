import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';

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
                          return DashboardAlermView();
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
            Expanded(child: Center(child: container)),
          ]),
        ));
  }
}

class DashboardAlermView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(236, 234, 234, 1.0)),
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Alarmes enfermaria 1"),
        centerTitle: true,
        ),
        body: AlertScreen(
          bedNumber: "0",
          isAllAlarms: true,
        ),
      ),
    );
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
    return Consumer<BedProvider>(
      builder: (__, model, _) {
        return GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: (130 / 177),
            children: List.generate(model.holder.length, (index) {
              var bedId = model.bedIds;
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BedDetails(bedId[index])),
                    );
                  },
                  child: BedComponent(
                    bedInfo: model.holder[bedId[index]].last,
                  ));
            }));
      },
    );
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
    return Consumer<BedProvider>(builder: (__, model, _) {
      return ListView.separated(
        itemCount: model.holder.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.black,
        ),
        itemBuilder: (BuildContext context, int index) {
          var bedId = model.bedIds;
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BedDetails(bedId[index])),
                );
              },
              child:
                  BedComponentList(bedInfo: model.holder[bedId[index]].last));
        },
      );
    });
  }
}
