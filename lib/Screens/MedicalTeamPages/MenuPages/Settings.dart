import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ThemeProvider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _toggleAirplaneMode = false;
  bool _toggleWifi = false;
  bool _toggleBluetooth = false;
  bool _toggleDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    SharedPreferences _prefs;
     SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
    return Scaffold(
      body: Column(
        children: [
          SwitchListTile(
            title: Text('Airplane Mode'),
            secondary: Icon(Icons.airplanemode_active),
            onChanged: (value) {
              setState(() {
                _toggleAirplaneMode = value;
              });
            },
            value: _toggleAirplaneMode,
          ),
          SwitchListTile(
            title: Text('Wi-Fi'),
            secondary: Icon(Icons.wifi),
            onChanged: (value) {
              setState(() {
                _toggleWifi = value;
              });
            },
            value: _toggleWifi,
          ),
          SwitchListTile(
            title: Text('Bluetooth'),
            secondary: Icon(Icons.bluetooth),
            onChanged: (value) {
              setState(() {
                _toggleBluetooth = value;
              });
            },
            value: _toggleBluetooth,
          ),

          SwitchListTile(
            title: Text('Modo Escuro'),
            secondary: Icon(Icons.bluetooth),
            onChanged: (value) {
              setState(() {
                themeNotifier.onThemeChanged(value, themeNotifier);
                themeNotifier.setSharedPrefDarkMode(value);
                _toggleDarkMode = value;
                print("[DEBUG]: AAAA ${_prefs.getBool('darkMode')}  e valueee $value");
                /*
                  TODO:
                  [] Switch de acordo com valor do shared SharedPreferences
                  [] Terminar cores de dark mode 
                */
              });
            },
            value: _toggleDarkMode,
          )
        ],
      ),
    );
  }
}
