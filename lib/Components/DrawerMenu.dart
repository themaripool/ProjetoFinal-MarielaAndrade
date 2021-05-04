import 'package:flutter/material.dart';
import 'package:projeto_final_1/Screens/Settings.dart';

class DrawerMenu extends StatelessWidget {
  
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[850],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Stack(children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://i.pinimg.com/originals/c9/85/9c/c9859c3719f1328d1795df856940ddfd.jpg'),
                    radius: 30.0,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight - Alignment(1.0, 0.1),
                  child: Text(
                    'John Doe',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight - Alignment(1.15, -0.3),
                  child: Text(
                    'Médico',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ]),
              decoration: BoxDecoration(
                color: Colors.grey[700],
              ),
            ),
            ListTile(
              selected: 0 == _selectedIndex,
              leading: Icon(
                Icons.add_circle,
                color: Colors.grey[700],
              ),
              title: Text(
                'Enfermaria',
                style: TextStyle(color: Colors.white70),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: 1 == _selectedIndex,
              leading: Icon(
                Icons.notifications,
                color: Colors.grey[700],
              ),
              title:
                  Text('Notificações', style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: 2 == _selectedIndex,
              leading: Icon(
                Icons.settings,
                color: Colors.grey[700],
              ),
              title: Text('Ajustes', style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Settings();
                }));
              },
            ),
            ListTile(
              selected: 3 == _selectedIndex,
              leading: Icon(
                Icons.search,
                color: Colors.grey[700],
              ),
              title: Text('Search', style: TextStyle(color: Colors.white70)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
