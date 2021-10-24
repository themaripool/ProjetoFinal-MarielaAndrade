import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import '../InpatientUseCase.dart';

/* TELA DE SINTOMAS DO PACIENTE

- Possui cards com sintomas
- Cada card possui dado observado e titulo
- Dado observado mudará de acordo com as mudancas do usuario
- Os cards sao clicaveis e abre um stepper de 1 a 5 com a severidade da dor

TODO:
[x] Notifier do Sintomas criado
[] Ver como mudar cor de acordo com dados recebidos
[] Ver como que ficar os dialogs com mais de uma opcao de Dor
[] ver como que salva no clique do botao
[] Alerta: espacamento + cor + tamanho

*/

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

  TextEditingController _others = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
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
                                    return InpatientRatingAlert("headache");
                                  },
                                );
                              },
                              child: SizedBox(
                                  width: 150,
                                  height: 100,
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
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Consumer<Symptoms>(builder:
                                            (context, headacheVal, child) {
                                          if (headacheVal.toStringHeadache() ==
                                              "-1") {
                                            return Text("Dado não inserido");
                                          }
                                          return Text(
                                              headacheVal.toStringHeadache());
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
                                    return InpatientRatingAlert("tiredness");
                                  },
                                );
                              },
                              child: SizedBox(
                                  width: 150,
                                  height: 100,
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
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Consumer<Symptoms>(builder:
                                            (context, tirednessVal, child) {
                                          if (tirednessVal.toStringTiredness() ==
                                              "-1") {
                                            return Text("Dado não inserido");
                                          }
                                          return Text(
                                              tirednessVal.toStringTiredness());
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
                                    return InpatientRatingAlert("pain");
                                  },
                                );
                              },
                              child: SizedBox(
                                  width: 150,
                                  height: 100,
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
                        ]),
                  ),


                  Spacer(),

                  /* SEGUNDA COLUNA COM OS CARDS */


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
                                    return InpatientRatingAlert("nausea");
                                  },
                                );
                              },
                              child: SizedBox(
                                  width: 150,
                                  height: 100,
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
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Consumer<Symptoms>(
                                            builder: (context, nauseaVal, child) {
                                          if (nauseaVal.toStringNausea() ==
                                              "-1") {
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
                                    return InpatientRatingAlert("diarrhea");
                                  },
                                );
                              },
                              child: SizedBox(
                                  width: 150,
                                  height: 100,
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
                                          style: TextStyle(fontSize: 18),
                                        ),
                                        Consumer<Symptoms>(builder:
                                            (context, diarrheaVal, child) {
                                          if (diarrheaVal.toStringDiarrhea() ==
                                              "-1") {
                                            return Text("Dado não inserido");
                                          }
                                          return Text(
                                              diarrheaVal.toStringDiarrhea());
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
                                    return InpatientRatingAlert("others");
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
                        ]),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () =>
                      {print("Tocou no salvar sintomas"), _showToast(context)},
                  child: Text("Salvar Sintomas"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey[850]),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Dados Salvos'),
        action: SnackBarAction(
            label: 'ok', onPressed: scaffold.hideCurrentSnackBar),
      ),
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
