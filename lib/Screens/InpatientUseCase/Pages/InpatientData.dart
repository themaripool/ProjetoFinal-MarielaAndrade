import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import '../InpatientUseCase.dart';
import 'InpatientDetails.dart';
import 'package:flutter/cupertino.dart';


/* TELA DE HOME DO PACIENTE

- Possui cards com os dados do News2
- Cada card possui Icone, nome e dado observado
- Dado observado mudará de acordo com as mensagens recebidas do mqtt
- Dependendo da severidade, borda do card mudará
- Os cards sao clicaveis e irão para tela de detalhes da cada um dos dados do News2

TODO:
[x] Após receber dados do back, fazer dados do card como observaveis
[x] Notifier do News2 criado - nao sera mais usado
[x] Ver como mudar cor de acordo com dados recebidos
*/


class PatientData extends StatefulWidget {
  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    return Consumer<BedProvider>(
      builder: (__, model, _) {
        if (model.holder.isEmpty) {
          if (_platform == TargetPlatform.iOS) {
            return Center(child: CupertinoActivityIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        } else {
          return GridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: (170 / 170),
              children: List.generate(4, (index) {
                var bedId = model.bedIds;
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InpatientDetails(index, bedId.first)),
                      );
                    },
                    child: InpatientHomeComponent( index, bedId.first));
              }));
        }
      },
    );
  }
}
