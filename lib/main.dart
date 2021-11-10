 import 'package:flutter/material.dart';
import 'Data/Data.dart';
import 'Screens/GeneralUseCase/GeneralUseCase.dart'; 


void main() async {
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Symptoms>(
          create: (_) => Symptoms(-1, -1, -1, -1, -1, "", "", "")),
      Provider<News2>(create: (_) => News2(32, 43, 54, 12, 32, 43)),
      ChangeNotifierProvider.value(value: BedProvider()),
      ChangeNotifierProvider<SwitchProvider>(create: (_) => SwitchProvider(),)
    ],
    child: TccApp(),
  ));
}

class TccApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}
