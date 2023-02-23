import 'package:app_medicine_scheduler/bloc/select_day_event.dart';
import 'package:app_medicine_scheduler/bloc/select_day_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectDayBloc extends Bloc<SelectDayEvent, SelectDayState> {
  SelectDayBloc() : super(SelectDayLoadedState(DateTime.now())) {
    on<UpdateSelectDay>(((event, emit) {
      emit(SelectDayLoadedState(event.selectDay));
    }));
  }
}
