abstract class Medicine {
  String name;
  DateTime initialDate;

  bool active;
  String? observation;

  Medicine(
    this.name,
    this.initialDate, {
    this.active = true,
    this.observation,
  });
}

class DailyMedicine extends Medicine {
  DailyMedicine(super.name, super.initialDate);
}

class WeeklyMedicine extends Medicine {
  WeeklyMedicine(super.name, super.initialDate);
}

class MonthlyMedicine extends Medicine {
  MonthlyMedicine(super.name, super.initialDate);
}

class PeriodicMedicine extends Medicine {
  Duration period;
  PeriodicMedicine(super.name, super.initialDate, this.period);
}

class SpecificHoursMedicine extends Medicine {
  List<Duration> offset;
  SpecificHoursMedicine(super.name, super.initialDate, this.offset);
}

// enum RecurrenceType {
//   daily,
//   weekly,
//   monthly,
//   daysPeriodic,
//   hoursPeriodic,
//   specificHours,
// }
