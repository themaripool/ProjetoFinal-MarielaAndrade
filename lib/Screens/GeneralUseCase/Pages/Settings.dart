import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GeneralUseCase.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences prefs;
  bool _toggleDarkMode = false;
  bool _toggleSoundMode;

  @override
  void initState() {
    super.initState();
    getSwitchValues();
  }

  getSwitchValues() async {
    _toggleSoundMode = await getSwitchState();
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("AlarmeBool", value);
    print('[SWT]: Switch Value saved $value');
    return prefs.setBool("AlarmeBool", value);
  }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _toggleSoundMode = prefs.getBool("AlarmeBool");
    print("[SWT]: getSwitchState $_toggleSoundMode");
    return _toggleSoundMode;
  }

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    if (_platform == TargetPlatform.iOS) {
      return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/c9/85/9c/c9859c3719f1328d1795df856940ddfd.jpg'),
                      radius: 30.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'John Doe',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Médico',
                    ),
                  ),
                ]
              ),
            ),
            ListTile(
                title: Text('Modo escuro'),
                leading: Icon(CupertinoIcons.moon),
                trailing: CupertinoSwitch(
                  onChanged: (value) {
                    setState(() {
                      _toggleDarkMode = value;
                    });
                  },
                  value: _toggleDarkMode,
                ),
                onTap: () {}),
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
    } else {
      return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://i.pinimg.com/originals/c9/85/9c/c9859c3719f1328d1795df856940ddfd.jpg'),
                      radius: 30.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'John Doe',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Médico',
                    ),
                  ),
                ]
              ),
            ),
            SwitchListTile(
              title: Text('Modo Escuro'),
              secondary: Icon(Icons.dark_mode),
              onChanged: (value) {
                setState(() {
                  _toggleDarkMode = value;
                });
              },
              value: _toggleDarkMode,
            ),
          ],
        ),
      );
    }
  }
}
