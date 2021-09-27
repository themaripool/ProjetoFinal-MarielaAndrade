import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/InpatientPage/Models/news2.dart';
import 'package:projeto_final_1/Screens/InpatientPage/Models/symptoms.dart';
import 'package:projeto_final_1/Screens/LoginPage/Login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/ThemeProvider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
  var darkModeOn = prefs.getBool('darkMode') ?? true;
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider<Symptoms>(create: (_) => Symptoms(-1, -1, -1, -1, -1, "")),
      Provider<News2>(create: (_) => News2(32, 43, 54, 12, 32, 43)),
       ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),),
    ],
    child: TccApp(),
  ));
  });
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

// SharedPreferences.getInstance().then((prefs) {
//   var darkModeOn = prefs.getBool('darkMode') ?? true;
//   runApp(
//     ChangeNotifierProvider<ThemeNotifier>(
//       builder: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
//       child: MyApp(),
//     ),
//   );
// });

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