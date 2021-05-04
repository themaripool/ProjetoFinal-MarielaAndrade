import 'package:flutter/material.dart';
import 'package:projeto_final_1/Components/DrawerMenu.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _toggleAirplaneMode = false;
  bool _toggleWifi = false;
  bool _toggleBluetooth = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AJUSTES"), centerTitle: true),
      drawer: DrawerMenu(),
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
          )
        ],
      ),
    );
  }
}
