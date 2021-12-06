class NavigationWebSymptoms extends StatelessWidget {
  String numberBed;
  NavigationWebSymptoms(this.numberBed);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sintomas do paciente"),
        centerTitle: true,
      ),
      body: PatientSymptoms(numberBed: numberBed, isInpatient: false),
    );
  }
}