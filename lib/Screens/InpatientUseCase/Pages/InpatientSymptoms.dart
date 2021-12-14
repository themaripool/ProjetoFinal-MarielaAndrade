/* PatientSymptoms: TELA DE SINTOMAS DO PACIENTE
- Cada card possui dado observado e titulo
- Dado observado mudará de acordo com as mudanças do usuário
- Os cards sao clicáveis e abre um stepper de 1 a 5 com a severidade da dor
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/GeneralUseCase.dart';
import 'package:projeto_final_1/WebAppFiles/mqttManagerWeb.dart';
import '../InpatientUseCase.dart';

class PatientSymptoms extends StatefulWidget {
  final numberBed;
  final isInpatient;
  PatientSymptoms({this.numberBed, this.isInpatient});
  @override
  _PatientSymptomsState createState() =>
      _PatientSymptomsState(numberBed, isInpatient);
}

class _PatientSymptomsState extends State<PatientSymptoms> {
  bool headache = false;
  bool tiredness = false;
  bool pain = false;
  bool nausea = false;
  bool diarrhea = false;
  bool other = false;
  String numberBed;
  bool isInpatient;

  _PatientSymptomsState(this.numberBed, this.isInpatient);

  String formattedDateHora;
  var viewModel = InpatientViewModel();

  TextEditingController _others = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;

    /* iOS */
    if (_platform == TargetPlatform.iOS) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(),
                ),
                PageBody(),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CupertinoButton(
                    color: CupertinoColors.systemGrey,
                    onPressed: () =>
                        {viewModel.saveSymptomsData(context, numberBed)},
                    child: Text("Salvar Sintomas"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CupertinoButton(
                    color: CupertinoColors.systemGrey,
                    onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (contextNavigation) {
                        return InpatientSymptomsHistory();
                      }))
                    },
                    child: Text("Ver histórico"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    /* Android */

    else if (_platform == TargetPlatform.android) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  PageBody(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      onPressed: () =>
                          {viewModel.saveSymptomsData(context, numberBed)},
                      child: Text("Salvar Sintomas"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey[850]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      onPressed: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (contextNavigation) {
                          return InpatientSymptomsHistory(
                            bedNumber: numberBed,
                            isInpatient: isInpatient,
                          );
                        }))
                      },
                      child: Text("Ver histórico"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey[850]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ))),
                    ),
                  ),
                ],
              ),
            ),
          ));
    }

    /* SINTOMAS WEB */

    else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: PageBody(),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DetailsAlertsPageWeb(numberBed, false),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          backgroundColor: Colors.green,
          onPressed: () {
            viewModel.saveSymptomsData(context, numberBed);
          },
        ),
      );
    }
  }
}

class DetailsAlertsPageWeb extends StatelessWidget {
  String bedId;
  bool allAlerts;
  /* var mock = [
    Symptom("1", "2", "3","4", "5", "outro", "12:12" , "Nao", "consciente", "12/12/2020", "teste1"),
  ]; */
  DetailsAlertsPageWeb(this.bedId, this.allAlerts);
  @override
  Widget build(BuildContext context) {
    MQTTManagerWeb().makePGQuery('SymptomsByBed', bedId);
    return Consumer<BedProvider>(builder: (__, model, _) {
      return SizedBox(
        height: 230,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: model.allSymptomByBed.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {},
                child: SymptomsListWeb(
                  model.allSymptomByBed[index].headache,
                  model.allSymptomByBed[index].nausea,
                  model.allSymptomByBed[index].tiredness,
                  model.allSymptomByBed[index].diarrea,
                  model.allSymptomByBed[index].pain,
                  model.allSymptomByBed[index].others,
                  model.allSymptomByBed[index].hourAndMinute,
                  model.allSymptomByBed[index].formattedDate,
                  model.allSymptomByBed[index].ox,
                  model.allSymptomByBed[index].conscience,
                ));
          },
        ),
      );
    });
  }
}

class SymptomsListWeb extends StatelessWidget {
  final String headache;
  final String nausea;
  final String tiredness;
  final String diarrea;
  final String pain;
  final String others;
  final String hourAndMinute;
  final String formattedDate;
  final String ox;
  final String conscience;
  SymptomsListWeb(
      this.headache,
      this.nausea,
      this.tiredness,
      this.diarrea,
      this.pain,
      this.others,
      this.hourAndMinute,
      this.formattedDate,
      this.ox,
      this.conscience);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              color: Color.fromRGBO(232, 245, 249, 1),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(color: Colors.grey.shade700, blurRadius: 5)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30,
                    height: 40,
                    child: SizedBox(child: Icon(Icons.warning_amber_rounded)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$formattedDate',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '$hourAndMinute',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Dor de Cabeça: $headache',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      'Nausea: $nausea',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      'Cansaço: $tiredness',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      'Oxigênio: $ox',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Conciência: $conscience',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      'Diarreia: $diarrea',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      'Dor: $pain',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Text(
                      'Outros: $others',
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class PageBody extends StatelessWidget {
  const PageBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Dor de Cabeça",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, headacheVal, child) {
                            if (headacheVal.toStringHeadache() == "-1") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(headacheVal.toStringHeadache(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
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
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Cansaço",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, tirednessVal, child) {
                            if (tirednessVal.toStringTiredness() == "-1") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(tirednessVal.toStringTiredness(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),

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
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Dor",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, painVal, child) {
                            if (painVal.toStringPain() == "-1") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(painVal.toStringPain(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
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
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Suplemetação de Oxigênio",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(builder: (context, val, child) {
                            if (val.toStringOx() == "") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(val.toStringOx(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Nausea",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, nauseaVal, child) {
                            if (nauseaVal.toStringNausea() == "-1") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(nauseaVal.toStringNausea(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
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
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Diarreia",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, diarrheaVal, child) {
                            if (diarrheaVal.toStringDiarrhea() == "-1") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(diarrheaVal.toStringDiarrhea(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),

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
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Outros",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, othersVal, child) {
                            if (othersVal.toStringOthers() == "") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(othersVal.toStringOthers(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
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
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Estado de consciência",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(builder: (context, val, child) {
                            if (val.toStringConscience() == "") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(val.toStringConscience(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
