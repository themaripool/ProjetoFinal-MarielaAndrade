import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:projeto_final_1/API/BedDataList.dart';
import 'package:projeto_final_1/API/mqttManager.dart';
import 'package:projeto_final_1/Components/AlertDialogPatient.dart';
import 'package:projeto_final_1/Components/BedComponent.dart';
import 'package:projeto_final_1/Components/BedComponentList.dart';
import 'package:projeto_final_1/Components/LevelComponent.dart';
import 'package:projeto_final_1/Screens/BedDetails.dart';
import 'package:projeto_final_1/Screens/Login.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

void _getBedInfo(BuildContext context) async {
  await Future.delayed(Duration(milliseconds: 200));
  BedProvider bedProvider = Provider.of<BedProvider>(context, listen: false);
  bedProvider.bedInfo = [];
}

void _updateBedInfo(int index, BedData bedData) {
  print("Chamou update bed info");
}

class _DashboardState extends State<Dashboard> {
  var status = true;
  var container;

  @override
  Widget build(BuildContext context) {
    _getBedInfo(context);

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
                        /* showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialogPatient();
                          },
                        ); */
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
    return Consumer<BedProvider>(
      builder: (__, model, _) {
        return GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: (130 / 177),
            children: List.generate(model.getBedListLen(), (index) {
              return GestureDetector(
                  onTap: () {
                    print(index = index); //index comeca em 0 BedDetails()
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BedDetails(model.bedDataListHistoryBed4)),
                    );
                  },
                  child: BedComponent(
                    index: index,
                    bedInfo: model.bedInfo[index],
                    updateCallback: _updateBedInfo,
                    deleteCallback: () => model.removeBedInfo(index),
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
    return Consumer<BedProvider>(
      builder: (__, model, _) {
        return ListView.separated(
          itemCount: model.getBedListLen(),
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BedDetails(model.bedDataListHistoryBed4)),
                  );
                },
                child: BedComponentList(bedInfo: model.bedInfo[index]));
          },
        );
      },
    );
  }
}
