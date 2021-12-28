/*
  Settings: Tela de ajustes, com botões de sair e de modo escuro
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../GeneralUseCase.dart';
import '../config.dart';

class SwitchProvider with ChangeNotifier {
  static bool isDarkMode = true;
  ThemeMode get currentTheme => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    //1
    return ThemeData(
      primaryColor: Colors.black,
      backgroundColor: Colors.grey[200],
      scaffoldBackgroundColor: Colors.grey[200],
      bottomAppBarColor: Colors.amber,
      appBarTheme: AppBarTheme(backgroundColor: Colors.grey[400]),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Colors.grey[350]),
      textTheme: ThemeData.light().textTheme,
      cardColor: Colors.blueGrey[200],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      cardColor: Colors.blueGrey[200],
      primaryColor: Colors.black,
      backgroundColor: Colors.grey[200],
      scaffoldBackgroundColor: Colors.grey,
      bottomAppBarColor: Colors.blue,
      textTheme: ThemeData.dark().textTheme,
      appBarTheme: AppBarTheme(backgroundColor: Colors.grey[800]),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Colors.grey[800]),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences prefs;
  bool _toggleDarkMode;
  String url = 'https://themaripool.github.io/PoliticaDePrivacidade/privacidade.pdf';

  @override
  void initState() {
    super.initState();
  }

   void launchURL() async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    _toggleDarkMode =
        currentTheme.currentTheme == ThemeMode.dark ? true : false;
    if (_platform == TargetPlatform.iOS) {
      /* Ajustes no modo cupertino */
      return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/originals/c9/85/9c/c9859c3719f1328d1795df856940ddfd.jpg'),
                    radius: 30.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Provider.of<BedProvider>(contextNavigation, listen: false)
                          .currentUserName,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ]),
            ),
            ListTile(
                title: Text('Modo escuro'),
                leading: Icon(CupertinoIcons.moon),
                trailing: CupertinoSwitch(
                  onChanged: (value) {
                    setState(() {
                      _toggleDarkMode = value;
                      currentTheme.toggleTheme();
                    });
                  },
                  value: _toggleDarkMode,
                ),
                onTap: () {}),
             ListTile(
                title: Text("Uso de dados"),
                leading: Icon(CupertinoIcons.doc_chart),
                onTap: () {
                  launchURL();
                }),
            ListTile(
                title: Text("Sobre o app"),
                leading: Icon(CupertinoIcons.info),
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child:  Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Sobre o App", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200),),
                                  SizedBox(height: 8.0),
                                  Text(Constants.aboutApp),
                                ],
                              )
                            ),
                        );
                      });
                }),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: CupertinoButton(
                child: Text('Log Out'),
                onPressed: () {
                  MQTTManager().app_request_logout();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            )
          ],
        ),
      );
    }
    /* Ajustes no modo material */
    else {
      return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Column(children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/originals/c9/85/9c/c9859c3719f1328d1795df856940ddfd.jpg'),
                    radius: 30.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Provider.of<BedProvider>(contextNavigation, listen: false)
                          .currentUserName,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ]),
            ),
            SwitchListTile(
              title: Text('Modo Escuro'),
              secondary: Icon(Icons.dark_mode),
              onChanged: (value) {
                setState(() {
                  _toggleDarkMode = value;
                  currentTheme.toggleTheme();
                });
              },
              value: _toggleDarkMode,
            ),
            ListTile(
                title: Text("Uso de dados"),
                leading: Icon(
                  Icons.data_usage,
                  size: 20,
                ),
                onTap: () {
                  launchURL();
                }),
            ListTile(
                title: Text("Sobre o app"),
                leading: Icon(
                  Icons.info,
                  size: 20,
                ),
                onTap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child:  Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Sobre o App", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 8.0),
                                  Text(Constants.aboutApp),
                                ],
                              )
                            ),
                        );
                      });
                }),
            ListTile(
                title: Text(
                  "Sair",
                ),
                leading: Icon(
                  Icons.exit_to_app,
                  size: 20,
                ),
                onTap: () {
                  MQTTManager().app_request_logout();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                }),
          ],
        ),
      );
    }
  }
}

class infoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [Text("abriu safado")],
      ),
    ));
  }
}
