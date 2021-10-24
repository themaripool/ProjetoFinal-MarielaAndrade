import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/GeneralUseCase/Pages/Login.dart';
import 'package:provider/provider.dart';

import 'Data/Provider/BedProvider.dart';
import 'Data/Provider/News2Provider.dart';
import 'Data/Provider/SymptomsProvider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Symptoms>(
          create: (_) => Symptoms(-1, -1, -1, -1, -1, "")),
      Provider<News2>(create: (_) => News2(32, 43, 54, 12, 32, 43)),
      ChangeNotifierProvider.value(value: BedProvider()),
    ],
    child: TccApp(),
  ));
}

class TccApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[850],
        accentColor: Colors.green,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.indigo,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Login(),
    );
  }
}
