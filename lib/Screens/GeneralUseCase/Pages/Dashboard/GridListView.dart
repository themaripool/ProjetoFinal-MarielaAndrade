/*
  GridListView: View com as camas em forma de grid. 
  Ao clicar na cama, redireciona para a tela com detalhes daquele leito
*/

import 'package:flutter/cupertino.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';
import '../../GeneralUseCase.dart';

class GridListView extends StatefulWidget {
  GridListView({Key key}) : super(key: key);

  @override
  _GridListViewState createState() => _GridListViewState();
}

class _GridListViewState extends State<GridListView> {
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
              crossAxisCount: 3,
              childAspectRatio: (90 / 140),
              children: List.generate(model.holder.length, (index) {
                var bedId = model.bedIds;
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BedDetails(bedId[index], -1)),
                      );
                    },
                    child: BedComponent(
                      bedInfo: model.holder[bedId[index]].last,
                    ));
              }));
        }
      },
    );
  }
}
