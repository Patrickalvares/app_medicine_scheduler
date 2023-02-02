import 'package:app_medicine_scheduler/models/medicine.dart';

abstract class MedicineState {}

class MedicineLoadedState extends MedicineState {
  List<Medicine> medicines;

  MedicineLoadedState(this.medicines);
}

class MedicineEmptyState extends MedicineState {}
