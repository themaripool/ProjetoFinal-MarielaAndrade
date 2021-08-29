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
                            onChanged: (value) async {
                              setState(() {
                                headache = !headache;
                              });
                              if (headache == true) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InpatientRatingAlert();
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
                            print("Headache val = $headacheVal");
                            return Text(headacheVal.toString());
                          }),
                        ]),

                    // /* Cansaço */

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Checkbox(
                    //     value: tiredness,
                    //     onChanged: (value) async {
                    //       setState(() {
                    //         tiredness = !tiredness;
                    //       });
                    //       if (tiredness == true) {
                    //         tirednessVal = await showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return InpatientRatingAlert();
                    //           },
                    //         );
                    //         tirednessVal = tirednessVal != null ? tirednessVal : 0 ;
                    //         print("$tirednessVal testeeee");
                    //       }
                    //     },
                    //   ),
                    //   Text(
                    //     "Cansaço",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    //   Text(" Nível de dor = $tirednessVal",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    // ]),

                    // /* Dor */

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Checkbox(
                    //     value: pain,
                    //     onChanged: (value) async {
                    //       setState(() {
                    //         pain = !pain;
                    //       });
                    //       if (pain == true) {
                    //         painVal = await showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return InpatientRatingAlert();
                    //           },
                    //         );
                    //         painVal = painVal != null ? painVal : 0 ;
                    //         print("$painVal testeeee");
                    //       }
                    //     },
                    //   ),
                    //   Text(
                    //     "Dor",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    //   Text(" Nível de dor = $painVal",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    // ]),

                    // /* Nausea */

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Checkbox(
                    //     value: nausea,
                    //     onChanged: (value) async {
                    //       setState(() {
                    //         nausea = !nausea;
                    //       });
                    //       if (nausea == true) {
                    //         nauseaVal = await showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return InpatientRatingAlert();
                    //           },
                    //         );
                    //         nauseaVal = nauseaVal != null ? nauseaVal : 0 ;
                    //         print("$nauseaVal testeeee");
                    //       }
                    //     },
                    //   ),
                    //   Text(
                    //     "Nausea",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    //   Text(" Nível de dor = $nauseaVal",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    // ]),

                    // /* Diarreia */

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Checkbox(
                    //     value: diarrhea,
                    //     onChanged: (value) async {
                    //       setState(() {
                    //         diarrhea = !diarrhea;
                    //       });
                    //       if (diarrhea == true) {
                    //         diarrheaVal = await showDialog(
                    //           context: context,
                    //           builder: (BuildContext context) {
                    //             return InpatientRatingAlert();
                    //           },
                    //         );

                    //         print("$diarrheaVal testeeee");
                    //       }
                    //     },
                    //   ),
                    //   Text(
                    //     "Diarreia",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    //   Text(" Nível de dor = $diarrheaVal",
                    //     style: TextStyle(fontSize: 18),
                    //   ),
                    // ]),

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
