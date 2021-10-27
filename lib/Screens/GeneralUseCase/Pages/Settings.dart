import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _toggleDarkMode = false;
  bool _toggleSoundMode = false;

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;

    if (_platform == TargetPlatform.iOS) {
      return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(CupertinoIcons.moon),
                    ),
                    Text('Modo Escuro'),
                  ],
                ), 
                CupertinoSwitch(
                  onChanged: (value) {
                    setState(() {
                      _toggleDarkMode = value;
                    });
                  },
                  value: _toggleDarkMode,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(CupertinoIcons.speaker_2),
                    ),
                    Text('Som do alarme'),
                  ],
                ), 
                CupertinoSwitch(
                  onChanged: (value) {
                    setState(() {
                      _toggleSoundMode = value;
                    });
                  },
                  value: _toggleSoundMode,
                ),
              ],
            ),
          ),
        ],
      ),
    );

    } else {
      return Scaffold(
      body: Column(
        children: [
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
          SwitchListTile(
            title: Text('Som do alarme'),
            secondary: Icon(Icons.music_note),
            onChanged: (value) {
              setState(() {
                _toggleSoundMode = value;
              });
            },
            value: _toggleSoundMode,
          ),
        ],
      ),
    );
    }
  }
}
