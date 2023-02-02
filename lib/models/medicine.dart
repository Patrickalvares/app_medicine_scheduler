class Medicine {
  String name;
  DateTime initialDate;
  RecurrenceType recurrenceType;
  bool active;
  int? period;
  List<DateTime>? specificHours;
  String? observation;

  Medicine(
    this.name,
    this.initialDate,
    this.recurrenceType, {
    this.active = true,
    this.period,
    this.specificHours,
    this.observation,
  });
}

enum RecurrenceType {
  daily,
  weekly,
  monthly,
  daysPeriodic,
  hoursPeriodic,
  specificHours,
}
