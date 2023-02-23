abstract class SelectDayState {}

class SelectDayLoadedState extends SelectDayState {
  DateTime selectDay;
  SelectDayLoadedState(this.selectDay);
}
