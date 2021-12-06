class MainPageContent extends StatelessWidget {
  final axisCount;
 MainPageContent({this.axisCount});
  @override
  Widget build(BuildContext context) {
    if (Provider.of<BedProvider>(context, listen: false).selectedSector ==
        null) {
      Provider.of<BedProvider>(context, listen: false).setSector("todos");
    }
    return Consumer<BedProvider>(
      builder: (__, model, _) {
        if (model.holder.isEmpty) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GridView.count(
              crossAxisCount: axisCount,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
              childAspectRatio: (140 / 140),
              children: List.generate(
                  model.bySector[model.selectedSector].length, (index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsPageWeb(
                                model.bySector[model.selectedSector][index]
                                    .bedNumber
                                    .toString(),
                                -1)),
                      );
                    },
                    child: BedComponent(
                      bedInfo: model.bySector[model.selectedSector][index],
                    ));
              }));
        }
      },
    );
  }
}
