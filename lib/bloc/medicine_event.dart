import 'package:app_medicine_scheduler/models/medicine.dart';

abstract class MedicineEvent {}

class AddMedicineEvent extends MedicineEvent {
  Medicine medicine;
  AddMedicineEvent(this.medicine);
}

class RemoveMedicineEvent extends MedicineEvent {
  Medicine medicine;
  RemoveMedicineEvent(this.medicine);
}
