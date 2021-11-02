/*
  ListViewPatients: View com as camas em forma de lista. 
  Ao clicar na cama, redireciona para a tela com detalhes daquele leito
*/

import 'package:flutter/cupertino.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';
import '../../GeneralUseCase.dart';

class ListViewPatients extends StatefulWidget {
  ListViewPatients({Key key}) : super(key: key);

  @override
  _ListViewPatientsState createState() => _ListViewPatientsState();
}

class _ListViewPatientsState extends State<ListViewPatients> {
  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    return Consumer<BedProvider>(builder: (__, model, _) {
      if (model.holder.isEmpty) {
        if (_platform == TargetPlatform.iOS) {
          return Center(child: CupertinoActivityIndicator());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      } else {
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
                        builder: (context) => BedDetails(bedId[index], -1)),
                  );
                },
                child:
                    BedComponentList(bedInfo: model.holder[bedId[index]].last));
          },
        );
      }
    });
  }
}
