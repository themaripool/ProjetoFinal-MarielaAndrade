import 'package:flutter/material.dart';

class MyAppWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePageWeb(),
    );
  }
}

class HomePageWeb extends StatefulWidget {
  @override
  _HomePageWebState createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  final List<String> elements = [
    "Zero",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "A Million Billion Trillion",
    "A much, much longer text that will still fit"
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(/* ... \*/),
        drawer: MediaQuery.of(context).size.width < 500
            ? Drawer(
                child: Menu(),
              )
            : null,
        body: SafeArea(
            child: Center(
                child: MediaQuery.of(context).size.width < 500
                    ? Content()
                    : Row(children: [
                        Container(width: 200.0, child: Menu()),
                        Container(
                            width: MediaQuery.of(context).size.width - 200.0,
                            child: Content())
                      ]))));
  }
}

class Content extends StatelessWidget {
  final List elements = [
    "Zero",
    "One",
    "Two",
    "Three",
    "Four",
    "Five",
    "Six",
    "Seven",
    "Eight",
    "A Million Billion Trillion",
    "A much, much longer text that will still fit"
  ];
  @override
  Widget build(context) => GridView.builder(
      itemCount: elements.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 130.0,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
      itemBuilder: (context, i) => Card(
          child: Center(
              child: Padding(
                  padding: EdgeInsets.all(8.0), child: Text(elements[i])))));
}

class Menu extends StatelessWidget {
  @override
  Widget build(context) => ListView(children: [
        FlatButton(
            onPressed: () {},
            child: ListTile(
              leading: Icon(Icons.looks_one),
              title: Text("First Link"),
            )),
        FlatButton(
            onPressed: () {},
            child: ListTile(
              leading: Icon(Icons.looks_two),
              title: Text("Second Link"),
            ))
      ]);
}
