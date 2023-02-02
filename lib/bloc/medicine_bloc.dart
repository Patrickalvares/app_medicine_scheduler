import 'package:app_medicine_scheduler/bloc/medicine_event.dart';
import 'package:app_medicine_scheduler/bloc/medicine_state.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  List<Medicine> medicines = [];
  MedicineBloc() : super(MedicineEmptyState()) {
    on<AddMedicineEvent>((event, emit) {
      medicines.add(event.medicine);
      emit(MedicineLoadedState(medicines));
    });
  }
}
