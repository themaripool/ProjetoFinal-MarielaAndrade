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
    if ( Provider.of<BedProvider>(context, listen: false).selectedSector == null){
      Provider.of<BedProvider>(context, listen: false).setSector("todos");
    }
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
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              childAspectRatio: ((MediaQuery.of(context).size.width * 0.45) / (MediaQuery.of(context).size.height * 0.4)),
              children: List.generate(model.bySector[model.selectedSector].length, (index) {
               // var bedId = model.bedIds;
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BedDetails(model.bySector[model.selectedSector][index].bedNumber.toString(), -1)),
                      );
                    },
                    child: BedComponent(
                      bedInfo: model.bySector[model.selectedSector][index],
                    ));
              }));
        }
      },
    );
  }
}
