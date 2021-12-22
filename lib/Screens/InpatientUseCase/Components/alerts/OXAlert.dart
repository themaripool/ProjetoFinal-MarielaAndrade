import 'package:projeto_final_1/Responsive.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/GeneralUseCase.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/InpatientUseCase.dart';

class OXAlert extends StatelessWidget {
  var text;
  var yes = false;
  var no = false;
  var viewModel = InpatientViewModel();
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 255,
            width: Responsive.isDesktop(context) ? MediaQuery.of(context).size.width/5 : MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
              child: Column(
                children: [
                  Text("Por favor, indique a suplementação de oxigênio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Theme.of(context).primaryColor),),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(onPressed: () {
                        text = 'Sim';
                        viewModel.setOxLevel(context, text);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Sim'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          text = 'Não';
                          viewModel.setOxLevel(context, text);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Não'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 60,
              child: Icon(Icons.report_problem_outlined, color: Colors.white, size: 50,),
            )
          ),
        ],
      )
    );
  }
}
