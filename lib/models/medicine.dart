abstract class Medicine {
  String name;
  DateTime initialDate;
  bool active;
  String? observation;
  String? periodicKind;

  Medicine(
    this.name,
    this.initialDate, {
    this.active = true,
    this.observation,
    this.periodicKind,
  });
}

class DailyMedicine extends Medicine {
  DailyMedicine(super.name, super.initialDate,
      {super.observation, super.active, super.periodicKind = 'Diariamente'});
}

class WeeklyMedicine extends Medicine {
  WeeklyMedicine(super.name, super.initialDate,
      {super.observation, super.active, super.periodicKind = 'Semanalmente'});
}

class MonthlyMedicine extends Medicine {
  MonthlyMedicine(super.name, super.initialDate,
      {super.observation, super.active, super.periodicKind = 'Mensalmente'});
}

class PeriodicMedicine extends Medicine {
  Duration period;
  PeriodicMedicine(super.name, super.initialDate, this.period,
      {super.observation, super.active, super.periodicKind = 'Personalizado'});
}

class SpecificHoursMedicine extends Medicine {
  List<Duration> offset;
  SpecificHoursMedicine(super.name, super.initialDate, this.offset,
      {super.observation, super.active, super.periodicKind = 'Personalizado'});
}
