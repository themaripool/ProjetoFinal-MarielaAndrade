/* PatientSymptoms: TELA DE SINTOMAS DO PACIENTE
- Cada card possui dado observado e titulo
- Dado observado mudará de acordo com as mudanças do usuário
- Os cards sao clicáveis e abre um stepper de 1 a 5 com a severidade da dor
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import '../InpatientUseCase.dart';

class PatientSymptoms extends StatefulWidget {
  @override
  _PatientSymptomsState createState() => _PatientSymptomsState();
}

class _PatientSymptomsState extends State<PatientSymptoms> {
  bool headache = false;
  bool tiredness = false;
  bool pain = false;
  bool nausea = false;
  bool diarrhea = false;
  bool other = false;

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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Title(),
                ),
                PageBody(),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CupertinoButton(
                    color: CupertinoColors.systemGrey,
                    onPressed: () => {viewModel.saveData(context)},
                    child: Text("Salvar Sintomas"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: CupertinoButton(
                    color: CupertinoColors.systemGrey,
                    onPressed: () => {
                      Navigator.push(contextNavigation,
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
    
    else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Title(),
                ),
                PageBody(),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () => {viewModel.saveData(context)},
                    child: Text("Salvar Sintomas"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey[850]),
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
                      Navigator.push(contextNavigation,
                          MaterialPageRoute(builder: (contextNavigation) {
                        return InpatientSymptomsHistory();
                      }))
                    },
                    child: Text("Ver histórico"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey[850]),
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
        ),
      );
    }
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
          padding: const EdgeInsets.only(left: 16),
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
                    width: 150,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Dor de Cabeça",
                            style: TextStyle(fontSize: 18),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, headacheVal, child) {
                            if (headacheVal.toStringHeadache() == "-1") {
                              return Text("Dado não inserido");
                            }
                            return Text(headacheVal.toStringHeadache());
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
                    width: 150,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Cansaço",
                            style: TextStyle(fontSize: 18),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, tirednessVal, child) {
                            if (tirednessVal.toStringTiredness() == "-1") {
                              return Text("Dado não inserido");
                            }
                            return Text(tirednessVal.toStringTiredness());
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
                    width: 150,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Dor",
                            style: TextStyle(fontSize: 18),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, painVal, child) {
                            if (painVal.toStringPain() == "-1") {
                              return Text("Dado não inserido");
                            }
                            return Text(painVal.toStringPain());
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
                    width: 150,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Suplemetação de Oxigênio",
                            style: TextStyle(fontSize: 18),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, val, child) {
                            if (val.toStringOx() == "") {
                              return Text("Dado não inserido");
                            }
                            return Text(val.toStringOx());
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
                    width: 150,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Nausea",
                            style: TextStyle(fontSize: 18),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, nauseaVal, child) {
                            if (nauseaVal.toStringNausea() == "-1") {
                              return Text("Dado não inserido");
                            }
                            return Text(nauseaVal.toStringNausea());
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
                    width: 150,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Diarreia",
                            style: TextStyle(fontSize: 18),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, diarrheaVal, child) {
                            if (diarrheaVal.toStringDiarrhea() == "-1") {
                              return Text("Dado não inserido");
                            }
                            return Text(diarrheaVal.toStringDiarrhea());
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
                    width: 150,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Outros",
                            style: TextStyle(fontSize: 18),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, othersVal, child) {
                            if (othersVal.toStringOthers() == "") {
                              return Text("Dado não inserido");
                            }
                            return Text(othersVal.toStringOthers());
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
                    width: 150,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Estado de consciência",
                            style: TextStyle(fontSize: 18),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, val, child) {
                            if (val.toStringConscience() == "") {
                              return Text("Dado não inserido");
                            }
                            return Text(val.toStringConscience());
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

class Title extends StatelessWidget {
  const Title({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Sintomas",
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w300,
        ));
  }
}
