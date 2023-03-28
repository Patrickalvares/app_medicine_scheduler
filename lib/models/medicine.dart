abstract class Medicine {
  String name;
  DateTime initialDate;
  bool active;
  String? observation;
  String? periodicKind;
  String id;

  Medicine(
    this.id,
    this.name,
    this.initialDate, {
    this.active = true,
    this.observation,
    this.periodicKind,
  });

  Map<String, dynamic> toMap() {
    var ret = {
      'name': name,
      'initialDate': initialDate.toIso8601String(),
      'active': active,
      'observation': observation,
      'periodicKind': periodicKind,
      'id': id,
    };

    if (ret['periodicKind'] == 'Personalizado') {
      ret['period'] = (this as PeriodicMedicine).period.inHours;
    }
    if (ret['periodicKind'] == 'Especifico') {
      ret['offset'] = (this as SpecificHoursMedicine).offset.toString();
    }
    return ret;
  }

  Medicine.fromMap(Map<String, dynamic> item)
      : id = item['id'],
        name = item['name'],
        initialDate = DateTime.parse(item['initialDate']),
        active = (item['active'] == 1) ? true : false,
        observation = item['observation'],
        periodicKind = item['periodicKind'];
}

class DailyMedicine extends Medicine {
  DailyMedicine(super.id, super.name, super.initialDate,
      {super.observation, super.active, super.periodicKind = 'Diariamente'});
  DailyMedicine.fromMap(Map<String, dynamic> item) : super.fromMap(item);
}

class WeeklyMedicine extends Medicine {
  WeeklyMedicine(super.id, super.name, super.initialDate,
      {super.observation, super.active, super.periodicKind = 'Semanalmente'});
  WeeklyMedicine.fromMap(Map<String, dynamic> item) : super.fromMap(item);
}

class MonthlyMedicine extends Medicine {
  MonthlyMedicine(super.id, super.name, super.initialDate,
      {super.observation, super.active, super.periodicKind = 'Mensalmente'});
  MonthlyMedicine.fromMap(Map<String, dynamic> item) : super.fromMap(item);
}

class PeriodicMedicine extends Medicine {
  Duration period;
  PeriodicMedicine(super.id, super.name, super.initialDate, this.period,
      {super.observation, super.active, super.periodicKind = 'Personalizado'});
  PeriodicMedicine.fromMap(Map<String, dynamic> item)
      : period = Duration(hours: item['period']),
        super.fromMap(item);
}

class SpecificHoursMedicine extends Medicine {
  List<Duration> offset;
  SpecificHoursMedicine(super.id, super.name, super.initialDate, this.offset,
      {super.observation, super.active, super.periodicKind = 'Especifico'});
  SpecificHoursMedicine.fromMap(Map<String, dynamic> item)
      : offset = item['offset'],
        super.fromMap(item);
}
