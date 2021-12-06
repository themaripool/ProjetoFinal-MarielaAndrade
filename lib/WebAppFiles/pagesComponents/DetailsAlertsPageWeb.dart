class DetailsAlertsPageWeb extends StatelessWidget {
  String bedId;
  bool allAlerts;
  DetailsAlertsPageWeb(this.bedId, this.allAlerts);
  @override
  Widget build(BuildContext context) {
    if (allAlerts == false) {
       MQTTManagerWeb().makePGQuery('AlarmsByBed', bedId);
    } else {
      MQTTManagerWeb().makePGQuery('allAlarms', bedId);
    }

    return Consumer<BedProvider>(builder: (__, model, _) {
      if (model.allAlertsByBed.isEmpty) {
        return Center(child: CircularProgressIndicator());
      } else {
      return ListView.builder(
        itemCount: model.allAlertsByBed.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {},
              child: AlertListWeb(
                model.allAlertsByBed[index].dateAndMonth,
                model.allAlertsByBed[index].hourAndMinute,
                model.allAlertsByBed[index].clinicalStatus,
                model.allAlertsByBed[index].bedId,
              ));
        },
      );
    }
    });
  }
}