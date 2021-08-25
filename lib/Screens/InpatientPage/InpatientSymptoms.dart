import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:projeto_final_1/Screens/InpatientPage/InpatientData.dart';
import 'package:projeto_final_1/Screens/InpatientPage/InpatientRatingAlert.dart';

class PatientSymptoms extends StatefulWidget {
  @override
  _PatientSymptomsState createState() => _PatientSymptomsState();
}

// TODO:
// Ver como que ficar os dialogs com mais de uma opcao de Dor
// ver como atualizar o texto do nivel de dor no dismiss do dialogs
// ver como que salva no clique do botao
// Alerta: espacamento + cor + tamanho


class _PatientSymptomsState extends State<PatientSymptoms> {
  bool headache = false;
  bool tiredness = false;
  bool pain = false;
  bool nausea = false;
  bool diarrhea = false;
  bool other = false;

  var returnValue = 0;

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
                    Row(children: [
                      Text(
                        "Dor de Cabeça",
                        style: TextStyle(fontSize: 18),
                      ),
                      Checkbox(
                        value: headache,
                        onChanged: (value) async {
                          setState(() {
                            headache = !headache;
                          });
                          if (headache == true) {
                            returnValue = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return InpatientRatingAlert();
                              },
                            );
                            print("$returnValue testeeee");
                          }
                        },
                      ),
                      Text("$returnValue",
                        style: TextStyle(fontSize: 18),
                      ),
                    ]),
                    // Visibility(
                    //   visible: headache,
                    //   child: FormBuilderSegmentedControl(
                    //       selectedColor: Colors.grey[700],
                    //       borderColor: Colors.grey[700],
                    //       name: "headache",
                    //       options: List.generate(6, (i) => (i - 1) + 1)
                    //           .map((number) =>
                    //               FormBuilderFieldOption(value: number))
                    //           .toList(),
                    //       onChanged: (number) => {
                    //             //pega o valor atual da escala
                    //             print("$number mudou aaa")
                    //           }),
                    // )
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Column(
            //       children: [
            //         Row(children: [
            //           Text("Cansaço", style: TextStyle(fontSize: 18)),
            //           Checkbox(
            //             value: tiredness,
            //             onChanged: (value) {
            //               setState(() {
            //                 tiredness = !tiredness;
            //               });
            //             },
            //           ),
            //         ]),
            //         Visibility(
            //           visible: tiredness,
            //           child: FormBuilderSegmentedControl(
            //             selectedColor: Colors.grey[700],
            //             borderColor: Colors.grey[700],
            //             name: "tiredness",
            //             options: List.generate(6, (i) => (i-1) + 1)
            //                 .map((number) =>
            //                     FormBuilderFieldOption(value: number))
            //                 .toList(),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Column(
            //       children: [
            //         Row(children: [
            //           Text("Dores no corpo", style: TextStyle(fontSize: 18)),
            //           Checkbox(
            //             value: pain,
            //             onChanged: (value) {
            //               setState(() {
            //                 pain = !pain;
            //               });
            //             },
            //           ),
            //         ]),
            //         Visibility(
            //           visible: pain,
            //           child: FormBuilderSegmentedControl(
            //             selectedColor: Colors.grey[700],
            //             borderColor: Colors.grey[700],
            //             name: "pain",
            //             options: List.generate(6, (i) => (i-1) + 1)
            //                 .map((number) =>
            //                     FormBuilderFieldOption(value: number))
            //                 .toList(),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Column(
            //       children: [
            //         Row(children: [
            //           Text("Diarréia", style: TextStyle(fontSize: 18)),
            //           Checkbox(
            //             value: diarrhea,
            //             onChanged: (value) {
            //               setState(() {
            //                 diarrhea = !diarrhea;
            //               });
            //             },
            //           ),
            //         ]),
            //         Visibility(
            //           visible: diarrhea,
            //           child: FormBuilderSegmentedControl(
            //             selectedColor: Colors.grey[700],
            //             borderColor: Colors.grey[700],
            //             name: "diarrhea",
            //             options: List.generate(6, (i) => (i-1) + 1)
            //                 .map((number) =>
            //                     FormBuilderFieldOption(value: number))
            //                 .toList(),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Column(
            //       children: [
            //         Row(children: [
            //           Text("Enjoô", style: TextStyle(fontSize: 18)),
            //           Checkbox(
            //             value: nausea,
            //             onChanged: (value) {
            //               setState(() {
            //                 nausea = !nausea;
            //               });
            //             },
            //           ),
            //         ]),
            //         Visibility(
            //           visible: nausea,
            //           child: FormBuilderSegmentedControl(
            //             selectedColor: Colors.grey[700],
            //             borderColor: Colors.grey[700],
            //             name: "nausea",
            //             options: List.generate(6, (i) => (i-1) + 1)
            //                 .map((number) =>
            //                     FormBuilderFieldOption(value: number))
            //                 .toList(),
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Column(
            //       children: [
            //         Row(children: [
            //           Text("Outro Sintoma", style: TextStyle(fontSize: 18)),
            //           Checkbox(
            //             value: other,
            //             onChanged: (value) {
            //               setState(() {
            //                 other = !other;
            //                 if (other == false){
            //                   _others.clear();
            //                 }
            //               });
            //             },
            //           ),
            //         ]),
            //         Visibility(
            //             visible: other,
            //             child: TextField(
            //               controller: _others,
            //               textAlign: TextAlign.center,
            //               style: TextStyle(fontSize: 20),
            //               keyboardType: TextInputType.text,
            //               decoration:
            //                   InputDecoration(hintText: "Digite seu sintoma"),
            //             ))
            //       ],
            //     ),
            //   ),
            // ),
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
