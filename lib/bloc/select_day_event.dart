abstract class SelectDayEvent {}

class UpdateSelectDay extends SelectDayEvent {
  DateTime selectDay;
  UpdateSelectDay(this.selectDay);
}
