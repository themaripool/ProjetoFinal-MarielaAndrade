import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientPage/InpatientRatingAlert.dart';
import 'package:projeto_final_1/Screens/InpatientPage/Models/symptoms.dart';
import 'package:provider/provider.dart';

class PatientSymptoms extends StatefulWidget {
  @override
  _PatientSymptomsState createState() => _PatientSymptomsState();
}

// TODO:
// Ver como que ficar os dialogs com mais de uma opcao de Dor
// ver como que salva no clique do botao
// Alerta: espacamento + cor + tamanho

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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text("Sintomas",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w300,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /* Dor de Cabeça */
                    
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            value: headache,
                            onChanged: (value) {
                              setState(() {
                                headache = !headache;
                              });
                              if (headache == true) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InpatientRatingAlert("headache");
                                  },
                                );
                              }
                            },
                          ),
                          Text(
                            "Dor de Cabeça",
                            style: TextStyle(fontSize: 18),
                          ),
                          Consumer<Symptoms>(builder: (context, headacheVal, child) {
                            print("Headache val = ${headacheVal.toStringHeadache()}");
                            if (headacheVal.toStringHeadache() == "-1"){
                              return Text("Dado não inserido");
                            }
                            return Text(headacheVal.toStringHeadache());
                          }),
                        ]),

                    // /* Cansaço */

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                        value: tiredness,
                        onChanged: (value){
                          setState(() {
                            tiredness = !tiredness;
                          });
                          if (tiredness == true) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return InpatientRatingAlert("tiredness");
                              },
                            );
                          }
                        },
                      ),
                      Text(
                        "Cansaço",
                        style: TextStyle(fontSize: 18),
                      ),
                      Consumer<Symptoms>(builder: (context, tirednessVal, child) {
                            print("Headache val = ${tirednessVal.toStringTiredness()}");
                            if (tirednessVal.toStringTiredness() == "-1"){
                              return Text("Dado não inserido");
                            }
                            return Text(tirednessVal.toStringTiredness());
                          }),
                    ]),

                    // /* Dor */

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                        value: pain,
                        onChanged: (value) {
                          setState(() {
                            pain = !pain;
                          });
                          if (pain == true) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return InpatientRatingAlert("pain");
                              },
                            );
                          }
                        },
                      ),
                      Text(
                        "Dor",
                        style: TextStyle(fontSize: 18),
                      ),
                      Consumer<Symptoms>(builder: (context, painVal, child) {
                            print("Headache val = ${painVal.toStringPain()}");
                            if (painVal.toStringPain() == "-1"){
                              return Text("Dado não inserido");
                            }
                            return Text(painVal.toStringPain());
                          }),
                    ]),

                    // /* Nausea */

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                        value: nausea,
                        onChanged: (value) {
                          setState(() {
                            nausea = !nausea;
                          });
                          if (nausea == true) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return InpatientRatingAlert("nausea");
                              },
                            );
                          }
                        },
                      ),
                      Text(
                        "Nausea",
                        style: TextStyle(fontSize: 18),
                      ),
                      Consumer<Symptoms>(builder: (context, nauseaVal, child) {
                            print("Headache val = ${nauseaVal.toStringNausea()}");
                            if (nauseaVal.toStringNausea() == "-1"){
                              return Text("Dado não inserido");
                            }
                            return Text(nauseaVal.toStringNausea());
                          }),
                    ]),

                    // /* Diarreia */

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                        value: diarrhea,
                        onChanged: (value) {
                          setState(() {
                            diarrhea = !diarrhea;
                          });
                          if (diarrhea == true) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return InpatientRatingAlert("diarrhea");
                              },
                            );
                          }
                        },
                      ),
                      Text(
                        "Diarreia",
                        style: TextStyle(fontSize: 18),
                      ),
                      Consumer<Symptoms>(builder: (context, diarrheaVal, child) {
                            print("Headache val = ${diarrheaVal.toStringDiarrhea()}");
                            if (diarrheaVal.toStringDiarrhea() == "-1"){
                              return Text("Dado não inserido");
                            }
                            return Text(diarrheaVal.toStringDiarrhea());
                          }),
                    ]),

                    // /* Outros */

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Checkbox(
                    //     value: other,
                    //     onChanged: (value) async {
                    //       setState(() {
                    //         other = !other;
                    //       });
                    //       if (other == true) {
                    //         otherVal = await showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return InpatientRatingAlert();
                    //           },
                    //         );
                    //         print("$otherVal testeeee");
                    //       }
                    //     },
                    //   ),
                    //   Text(
                    //     "Outros",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    //   Text(" Nível de dor = $otherVal",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    // ]),
                  ],
                ),
              ),
            ),
            ElevatedButton(
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
            )
          ],
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
