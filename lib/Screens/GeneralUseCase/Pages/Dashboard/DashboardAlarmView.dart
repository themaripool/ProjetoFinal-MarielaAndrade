/*
  DashboardAlarmView: View com todos os alertas recebidos
*/

import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/config.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';
import '../../GeneralUseCase.dart';

class DashboardAlarmView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SwitchProvider.lightTheme,
      darkTheme: SwitchProvider.darkTheme,
      themeMode: currentTheme.currentTheme,
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Alarmes enfermaria 1", style: TextStyle(color: Colors.black),),
        ),
        body: AlertScreen(
          bedNumber: "0",
          isAllAlarms: true,
        ),
      ),
    );
  }
}