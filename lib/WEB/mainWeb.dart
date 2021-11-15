import 'package:flutter/material.dart';
import 'package:projeto_final_1/Models/BedModel.dart';
import 'package:projeto_final_1/Screens/MedicalTeamUseCase/MedicalTeamUseCase.dart';

class MyAppWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final TextEditingController _userNameCntl = TextEditingController();
  // final TextEditingController _passwordCntl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        /* PreferredSize(
            preferredSize: Size(screenSize.width, 1000),
            child: Container(
                color: Colors.grey,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text("WkitSimulator-WEB"),
                    ],
                  ),
                ))), */
        drawer: MediaQuery.of(context).size.width < 800
            ? Drawer(
                child: Menu(),
              )
            : null,
        body: SafeArea(
            child: Center(
                child: 
                MediaQuery.of(context).size.width < 800 && MediaQuery.of(context).size.width > 500
                    ? Container(width: 400, child: Content(axisCount: 2,)) 
                    : MediaQuery.of(context).size.width > 800 &&  MediaQuery.of(context).size.width <= 1004
                    ? Row(children: [
                        Container(width: 200.0, child: Menu()),
                        Container(
                            width: MediaQuery.of(context).size.width - 200.0,
                            child: Content(axisCount: 3,)
                        ),
                      ]
                    )
                    :MediaQuery.of(context).size.width > 1004 &&  MediaQuery.of(context).size.width <= 1300
                    ? Row(children: [
                        Container(width: 200.0, child: Menu()),
                        Container(
                            width: MediaQuery.of(context).size.width - 200.0,
                            child: Content(axisCount: 4,)
                        ),
                      ]
                    )
                    : MediaQuery.of(context).size.width > 1300 &&  MediaQuery.of(context).size.width <= 1500
                    ? Row(children: [
                        Container(width: 200.0, child: Menu()),
                        Container(
                            width: MediaQuery.of(context).size.width - 200.0,
                            child: Content(axisCount: 5,)
                        ),
                      ]
                    )
                    : MediaQuery.of(context).size.width > 1500 
                    ? Row(children: [
                        Container(width: 200.0, child: Menu()),
                        Container(
                            width: MediaQuery.of(context).size.width - 200.0,
                            child: Content(axisCount: 6,)
                        ),
                      ]
                    )
                    : MediaQuery.of(context).size.width < 400 
                    ? Container(width: 200, child: Content(axisCount: 1,)) 
                    : Container(width: 200, child: Content(axisCount: 1,))
                )
        )
              );
  }
}

class Content extends StatelessWidget {
  final axisCount;
  Content({this.axisCount});

  var mock = BedData(
      bedNumber: 1,
      dateDetails: "12/12/2021",
      fc: 98,
      fr: 60,
      sector: "3",
      so: 2,
      te: 32.1);

  @override
  Widget build(context) => GridView.count(
      crossAxisCount: axisCount,
      crossAxisSpacing: 20,
      mainAxisSpacing: 10,
      childAspectRatio: 1,
      children: List.generate(10, (index) {
        return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => BedDetails("1", -1)),
              // );
            },
            child: BedComponent(bedInfo: mock));
      }));
}

class Menu extends StatelessWidget {
  @override
  Widget build(context) => ListView(children: [
        FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text("Setor 1"),
            )),
        FlatButton(
            onPressed: () {},
            child: ListTile(
              title: Text("Setor 2"),
            )),
        ListTile(
            title: Text(
              "Sair",
            ),
            leading: Icon(
              Icons.exit_to_app,
              size: 20,
            ),
            onTap: () {
              print("logout do mqtt");
            }),
      ]);
}

class StarageDetails extends StatelessWidget {
  const StarageDetails({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Storage Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
