/*
  DashboardAlarmView: View com todos os alertas recebidos
*/

import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';
import '../../GeneralUseCase.dart';

class DashboardAlarmView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(236, 234, 234, 1.0)),
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Alarmes enfermaria 1"),
        centerTitle: true,
        ),
        body: AlertScreen(
          bedNumber: "0",
          isAllAlarms: true,
        ),
      ),
    );
  }
}