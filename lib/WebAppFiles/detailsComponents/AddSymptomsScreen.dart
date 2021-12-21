import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Data/Provider/SymptomsProvider.dart';
import 'package:projeto_final_1/Responsive.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';

class AddSymptomsScreen extends StatefulWidget {
  final numberBed;
  AddSymptomsScreen({this.numberBed});

  @override
  _AddSymptomsScreenState createState() => _AddSymptomsScreenState(numberBed);
}

class _AddSymptomsScreenState extends State<AddSymptomsScreen> {
  String numberBed;

  _AddSymptomsScreenState(this.numberBed);

  var viewModel = InpatientViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        actions: [
          ElevatedButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              padding: EdgeInsets.symmetric(
                horizontal: 16 * 1.5,
                vertical: 16 / (Responsive.isMobile(context) ? 2 : 1),
              ),
            ),
            onPressed: () {
              viewModel.saveSymptomsData(context, numberBed);
            },
            icon: Icon(Icons.save), //botao add new
            label: Text(
              "Salvar",
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.grey[350],
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        "Selecione os sintomas do paciente: ",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /* Dor de Cabeça */

                                Card(
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SymptomsAlert("headache");
                                        },
                                      );
                                    },
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5, //150
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2, //100
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Dor de Cabeça",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              Consumer<Symptoms>(builder:
                                                  (context, headacheVal,
                                                      child) {
                                                if (headacheVal
                                                        .toStringHeadache() ==
                                                    "-1") {
                                                  return Text(
                                                      "Dado não inserido",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor));
                                                }
                                                return Text(
                                                    headacheVal
                                                        .toStringHeadache(),
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor));
                                              }),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),

                                // // /* Cansaço */

                                Card(
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SymptomsAlert("tiredness");
                                        },
                                      );
                                    },
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5, //150
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2, //100
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Cansaço",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              Consumer<Symptoms>(builder:
                                                  (context, tirednessVal,
                                                      child) {
                                                if (tirednessVal
                                                        .toStringTiredness() ==
                                                    "-1") {
                                                  return Text(
                                                      "Dado não inserido",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor));
                                                }
                                                return Text(
                                                    tirednessVal
                                                        .toStringTiredness(),
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor));
                                              }),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ]),
                        ),
                        Spacer(),

                        /* SEGUNDA COLUNA COM OS CARDS */

                        Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // // /* Dor */

                                  Card(
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SymptomsAlert("pain");
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5, //150
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2, //100
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Dor",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Consumer<Symptoms>(builder:
                                                    (context, painVal, child) {
                                                  if (painVal.toStringPain() ==
                                                      "-1") {
                                                    return Text(
                                                        "Dado não inserido",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor));
                                                  }
                                                  return Text(
                                                      painVal.toStringPain(),
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor));
                                                }),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),

                                  Card(
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return OXAlert();
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5, //150
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2, //100
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "Suplemetação de Oxigênio",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Consumer<Symptoms>(builder:
                                                    (context, val, child) {
                                                  if (val.toStringOx() == "") {
                                                    return Text(
                                                        "Dado não inserido",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor));
                                                  }
                                                  return Text(val.toStringOx(),
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor));
                                                }),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ])),
                        Spacer(),

                        /* TERCEIRA COLUNA COM OS CARDS */

                        Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // // /* Nausea */

                                  Card(
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SymptomsAlert("nausea");
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5, //150
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2, //100
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Nausea",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Consumer<Symptoms>(builder:
                                                    (context, nauseaVal,
                                                        child) {
                                                  if (nauseaVal
                                                          .toStringNausea() ==
                                                      "-1") {
                                                    return Text(
                                                        "Dado não inserido",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor));
                                                  }
                                                  return Text(
                                                      nauseaVal
                                                          .toStringNausea(),
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor));
                                                }),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),

                                  // // /* Diarreia */

                                  Card(
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SymptomsAlert("diarrhea");
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5, //150
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2, //100
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  "Diarreia",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                                Consumer<Symptoms>(builder:
                                                    (context, diarrheaVal,
                                                        child) {
                                                  if (diarrheaVal
                                                          .toStringDiarrhea() ==
                                                      "-1") {
                                                    return Text(
                                                        "Dado não inserido",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor));
                                                  }
                                                  return Text(
                                                      diarrheaVal
                                                          .toStringDiarrhea(),
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor));
                                                }),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                ])),

                        /* QUARTA COLUNA COM OS CARDS */
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // /* Outros */

                                Card(
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return OtherAlert();
                                        },
                                      );
                                    },
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5, //150
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2, //100
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Outros",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              Consumer<Symptoms>(builder:
                                                  (context, othersVal, child) {
                                                if (othersVal
                                                        .toStringOthers() ==
                                                    "") {
                                                  return Text(
                                                      "Dado não inserido",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor));
                                                }
                                                return Text(
                                                    othersVal.toStringOthers(),
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor));
                                              }),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),

                                Card(
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ConscienceAlert();
                                        },
                                      );
                                    },
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2, //100
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "Estado de consciência",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              Consumer<Symptoms>(builder:
                                                  (context, val, child) {
                                                if (val.toStringConscience() ==
                                                    "") {
                                                  return Text(
                                                      "Dado não inserido",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor));
                                                }
                                                return Text(
                                                    val.toStringConscience(),
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor));
                                              }),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
