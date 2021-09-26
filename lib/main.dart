import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientPage/Models/news2.dart';
import 'package:projeto_final_1/Screens/InpatientPage/Models/symptoms.dart';
import 'package:projeto_final_1/Screens/LoginPage/Login.dart';
import 'package:provider/provider.dart';

import 'Screens/ThemeProvider.dart';



void main() async {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider<Symptoms>(create: (_) => Symptoms(-1, -1, -1, -1, -1, "")),
      Provider<News2>(create: (_) => News2(32, 43, 54, 12, 32, 43)),
       ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier(darkTheme),),
    ],
    child: TccApp(),
  ));
}

//      ChangeNotifierProvider(create: (ctx) => ThemeProvider(),),

class TccApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: 'Chitr',
      theme: themeNotifier.getTheme(),
      home: Login(),
    );
  }
}

// MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.grey[850],
//         accentColor: Colors.green,
//         buttonTheme: ButtonThemeData(
//           buttonColor: Colors.indigo,
//           textTheme: ButtonTextTheme.primary,
//         ),
//       ),
//       home: Login(),
//     );