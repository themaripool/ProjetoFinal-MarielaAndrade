import 'package:flutter/material.dart';
import 'package:projeto_final_1/Data/Data.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/Components/alerts/ConscienceAlert.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/Components/alerts/OXAlert.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/Components/alerts/OtherAlert.dart';
import 'package:projeto_final_1/Screens/InpatientUseCase/Components/alerts/SymptomsAlert.dart';
import 'package:projeto_final_1/WebAppFiles/alertComponents.dart/AlertComponents.dart';
import 'package:projeto_final_1/WebAppFiles/dataScreenWeb.dart';
import 'package:projeto_final_1/WebAppFiles/detailsComponents/DetailsComponents.dart';

class DetailsPageWeb extends StatelessWidget {
  String bedId;
  int initialIndex;
  DetailsPageWeb(this.bedId, this.initialIndex);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
        title: Text("SmartAlarmsWeb"),
      ),
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              MiniInformation(), //quadradinhos
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        DataScreenWeb(
                          bedId: bedId,
                        ), //RecentDiscussions(), //discussos
                        // if (Responsive.isMobile(context)) SizedBox(height: 16),
                        // if (Responsive.isMobile(context)) UserDetailsWidget(),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        SizedBox(height: 80),
                        AllAlertsList(bedId),
                        SizedBox(height: 16),
                        AllSymptomsList(bedId)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormMaterial extends StatefulWidget {
  @override
  _FormMaterialState createState() => _FormMaterialState();
}

class _FormMaterialState extends State<FormMaterial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[350],
      ),
      body: SingleChildScrollView(
        child: Card(
          color: Colors.grey[350],
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Center(
                      child: Text("What you want to add? Select from below?"),
                    ),
                    Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            /* Dor de Cabeça */

            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SymptomsAlert("headache");
                    },
                  );
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Dor de Cabeça",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, headacheVal, child) {
                            if (headacheVal.toStringHeadache() == "-1") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(headacheVal.toStringHeadache(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),

            // // /* Cansaço */

            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SymptomsAlert("tiredness");
                    },
                  );
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Cansaço",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, tirednessVal, child) {
                            if (tirednessVal.toStringTiredness() == "-1") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(tirednessVal.toStringTiredness(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),

            // // /* Dor */

            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SymptomsAlert("pain");
                    },
                  );
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Dor",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, painVal, child) {
                            if (painVal.toStringPain() == "-1") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(painVal.toStringPain(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return OXAlert();
                    },
                  );
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Suplemetação de Oxigênio",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(builder: (context, val, child) {
                            if (val.toStringOx() == "") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(val.toStringOx(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),
          ]),
        ),
        Spacer(),

        /* SEGUNDA COLUNA COM OS CARDS */

        Padding(
          padding: const EdgeInsets.only(right: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // // /* Nausea */

            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SymptomsAlert("nausea");
                    },
                  );
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Nausea",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, nauseaVal, child) {
                            if (nauseaVal.toStringNausea() == "-1") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(nauseaVal.toStringNausea(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),

            // // /* Diarreia */

            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SymptomsAlert("diarrhea");
                    },
                  );
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Diarreia",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, diarrheaVal, child) {
                            if (diarrheaVal.toStringDiarrhea() == "-1") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(diarrheaVal.toStringDiarrhea(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),

            // /* Outros */

            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return OtherAlert();
                    },
                  );
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Outros",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(
                              builder: (context, othersVal, child) {
                            if (othersVal.toStringOthers() == "") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(othersVal.toStringOthers(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),

            Card(
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConscienceAlert();
                    },
                  );
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.43, //150
                    height: MediaQuery.of(context).size.height * 0.2, //100
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Estado de consciência",
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          Consumer<Symptoms>(builder: (context, val, child) {
                            if (val.toStringConscience() == "") {
                              return Text("Dado não inserido",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor));
                            }
                            return Text(val.toStringConscience(),
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor));
                          }),
                        ],
                      ),
                    )),
              ),
            ),
          ]),
        ),
      ],
    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}

class SelectionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
        SizedBox(height: 16),
        Responsive(
          mobile: InformationCard(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.2 : 1,
          ),
          tablet: InformationCard(),
          desktop: InformationCard(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.3,
          ),
        ),
      ],
    );
  }
}

class MiniInformation extends StatelessWidget {
  const MiniInformation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * 1.5,
                  vertical: 16 / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute<Null>(
                    builder: (BuildContext context) {
                      return new FormMaterial();
                    },
                    fullscreenDialog: false));
              },
              icon: Icon(Icons.add), //botao add new
              label: Text(
                "Adicionar sintomas",
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        // SizedBox(height: defaultPadding),
        // Responsive(
        //   mobile: InformationCard(
        //     crossAxisCount: _size.width < 650 ? 2 : 4,
        //     childAspectRatio: _size.width < 650 ? 1.2 : 1,
        //   ),
        //   tablet: InformationCard(),
        //   desktop: InformationCard(
        //     childAspectRatio: _size.width < 1400 ? 1.2 : 1.4,
        //   ),
        // ),
      ],
    );
  }
}

class InformationCard extends StatelessWidget {
  const InformationCard({
    Key key,
    this.crossAxisCount = 5,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 0, //dailyDatas.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          MiniInformationWidget(dailyData: dailyDatas[index]),
    );
  }
}

class MiniInformationWidget extends StatefulWidget {
  const MiniInformationWidget({
    Key key,
    this.dailyData,
  }) : super(key: key);
  final DailyInfoModel dailyData;

  @override
  _MiniInformationWidgetState createState() => _MiniInformationWidgetState();
}

int _value = 1;

class _MiniInformationWidgetState extends State<MiniInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF292929),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(16 * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: widget.dailyData.color.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Icon(
                  widget.dailyData.icon,
                  color: widget.dailyData.color,
                  size: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: DropdownButton(
                  icon: Icon(Icons.more_vert, size: 18),
                  underline: SizedBox(),
                  style: Theme.of(context).textTheme.button,
                  value: _value,
                  items: [
                    DropdownMenuItem(
                      child: Text("Daily"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Weekly"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Monthly"),
                      value: 3,
                    ),
                  ],
                  onChanged: (int value) {
                    setState(() {
                      _value = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.dailyData.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 8,
              ),
              /* Container(
                child: LineChartWidget(
                  colors: widget.dailyData.colors,
                  spotsData: widget.dailyData.spots,
                ),
              ) */
            ],
          ),
          SizedBox(
            height: 8,
          ),
          /* ProgressLine(
            color: widget.dailyData.color!,
            percentage: widget.dailyData.percentage!,
          ), */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.dailyData.volumeData}",
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white70),
              ),
              Text(
                widget.dailyData.totalStorage,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key key,
    this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (_size.width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (_size.width >= 850) {
      return tablet;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}

class DailyInfoModel {
  IconData icon;
  String title;
  String totalStorage;
  int volumeData;
  int percentage;
  Color color;
  List<Color> colors;

  DailyInfoModel({
    this.icon,
    this.title,
    this.totalStorage,
    this.volumeData,
    this.percentage,
    this.color,
    this.colors,
  });

  DailyInfoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    volumeData = json['volumeData'];
    icon = json['icon'];
    totalStorage = json['totalStorage'];
    color = json['color'];
    percentage = json['percentage'];
    colors = json['colors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['volumeData'] = this.volumeData;
    data['icon'] = this.icon;
    data['totalStorage'] = this.totalStorage;
    data['color'] = this.color;
    data['percentage'] = this.percentage;
    data['colors'] = this.colors;
    return data;
  }
}

List<DailyInfoModel> dailyDatas =
    dailyData.map((item) => DailyInfoModel.fromJson(item)).toList();

//List<FlSpot> spots = yValues.asMap().entries.map((e) {
//  return FlSpot(e.key.toDouble(), e.value);
//}).toList();

var dailyData = [
  {
    "title": "Employee",
    "volumeData": 1328,
    "icon": Icons.ac_unit,
    "totalStorage": "+ %20",
    "color": Color(0xFFFFA113),
    "percentage": 35,
    "colors": [
      Color(0xff23b6e6),
      Color(0xff02d39a),
    ],
  },
  {
    "title": "On Leave",
    "volumeData": 1328,
    "icon": Icons.ac_unit,
    "totalStorage": "+ %5",
    "color": Color(0xFFFFA113),
    "percentage": 35,
    "colors": [Color(0xfff12711), Color(0xfff5af19)],
  },
  {
    "title": "Onboarding",
    "volumeData": 1328,
    "icon": Icons.ac_unit,
    "totalStorage": "+ %8",
    "color": Color(0xFFA4CDFF),
    "percentage": 10,
    "colors": [Color(0xff2980B9), Color(0xff6DD5FA)],
  },
  {
    "title": "Open Position",
    "volumeData": 1328,
    "icon": Icons.ac_unit,
    "totalStorage": "+ %8",
    "color": Color(0xFFd50000),
    "percentage": 10,
    "colors": [Color(0xff93291E), Color(0xffED213A)],
  },
  {
    "title": "Efficiency",
    "volumeData": 5328,
    "icon": Icons.ac_unit,
    "totalStorage": "- %5",
    "color": Color(0xFF00F260),
    "percentage": 78,
    "colors": [Color(0xff0575E6), Color(0xff00F260)],
  }
];
