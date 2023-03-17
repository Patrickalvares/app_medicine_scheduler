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
    return {
      'name': name,
      'initialDate': initialDate.toIso8601String(),
      'active': active,
      'observation': observation,
      'periodicKind': periodicKind,
      'id': id,
    };
  }
}

class DailyMedicine extends Medicine {
  DailyMedicine(super.id, super.name, super.initialDate,
      {super.observation, super.active, super.periodicKind = 'Diariamente'});
}

class WeeklyMedicine extends Medicine {
  WeeklyMedicine(super.id, super.name, super.initialDate,
      {super.observation, super.active, super.periodicKind = 'Semanalmente'});
}

class MonthlyMedicine extends Medicine {
  MonthlyMedicine(super.id, super.name, super.initialDate,
      {super.observation, super.active, super.periodicKind = 'Mensalmente'});
}

class PeriodicMedicine extends Medicine {
  Duration period;
  PeriodicMedicine(super.id, super.name, super.initialDate, this.period,
      {super.observation, super.active, super.periodicKind = 'Personalizado'});
}

class SpecificHoursMedicine extends Medicine {
  List<Duration> offset;
  SpecificHoursMedicine(super.id, super.name, super.initialDate, this.offset,
      {super.observation, super.active, super.periodicKind = 'Personalizado'});
}
