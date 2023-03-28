import 'package:app_medicine_scheduler/SQL/database_helper.dart';
import 'package:app_medicine_scheduler/bloc/medicine_event.dart';
import 'package:app_medicine_scheduler/bloc/medicine_state.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  // static final List<Medicine> initialMedicines = [
  //   MonthlyMedicine('0', 'Viagra', DateTime.utc(2023, 03, 31, 10, 15),
  //       observation: 'Azulzinho'),
  //   DailyMedicine('1', 'Tilenol', DateTime.utc(2023, 02, 07, 15, 30),
  //       observation: 'Dor de cabeça'),
  //   WeeklyMedicine('3', 'Doril', DateTime.utc(2023, 02, 22, 22, 55),
  //       observation: 'A dor sumio'),
  //   PeriodicMedicine('4', 'Cloroquina', DateTime.utc(2023, 02, 28, 19, 40),
  //       const Duration(days: 5),
  //       observation: 'Faz arminha com a Mão'),
  //   PeriodicMedicine('5', 'Ritalina', DateTime.utc(2023, 02, 27, 23, 00),
  //       const Duration(hours: 15, minutes: 0),
  //       observation: 'Pra doido')
  // ];

  List<Medicine> medicines = [];
  MedicineBloc() : super(MedicineEmptyState()) {
    on<AddMedicineEvent>(handleAddMedicineEvent);
    on<RemoveMedicineEvent>(handleRemoveMedicineEvent);
    on<FetchMedicineEvent>(handleFetchMedicineEvent);
  }
  void handleAddMedicineEvent(
      AddMedicineEvent event, Emitter<MedicineState> emit) {
    DatabaseHelper()
        .insertMedicine(event.medicine)
        .then((value) => DatabaseHelper().queryAllRows());

    medicines.add(event.medicine);
    emit(MedicineLoadedState(medicines));
  }

  void handleRemoveMedicineEvent(
      RemoveMedicineEvent event, Emitter<MedicineState> emit) {
    medicines.remove(event.medicine);
    emit(MedicineLoadedState(medicines));
  }

  void handleUpdateMedicineEvent(
      UpdateMedicineEvent event, Emitter<MedicineState> emit) {}

  Future handleFetchMedicineEvent(
      FetchMedicineEvent event, Emitter<MedicineState> emit) async {
    medicines = await DatabaseHelper().getMedicinesFromTable();
    emit(MedicineLoadedState(medicines));
  }
}
