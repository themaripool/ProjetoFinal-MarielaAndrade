
class Symptom {
  String headache;
  String nausea;
  String tiredness;
  String diarrea;
  String pain;
  String others;
  String hourAndMinute;
  String ox;
  String conscience;

  Symptom(this.headache, this.nausea, this.tiredness, this.diarrea,
      this.pain, this.others, this.hourAndMinute, this.ox, this.conscience);

  Symptom.fromJson(Map<dynamic, dynamic> json)
      : headache = json['headache'] as String,
        nausea = json['nausea'] as String,
        tiredness = json['tiredness'] as String,
        diarrea = json['diarrea'] as String,
        pain = json['pain'] as String,
        others = json['others'] as String,
        hourAndMinute = json['hourAndMinute'] as String,
        ox = json['ox'] as String,
        conscience = json['conscience'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'headache': headache,
        'nausea': nausea,
        'tiredness': tiredness,
        'diarrea': diarrea,
        'pain': pain,
        'others': others,
        'hourAndMinute': hourAndMinute,
        'ox': ox,
        'conscience': conscience
      };
}