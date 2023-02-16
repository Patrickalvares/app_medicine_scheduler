import 'package:app_medicine_scheduler/bloc/medicine_bloc.dart';
import 'package:app_medicine_scheduler/bloc/medicine_state.dart';
import 'package:app_medicine_scheduler/components/medicine_preview.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedDayMedicines extends StatefulWidget {
  const SelectedDayMedicines({super.key});

  @override
  State<SelectedDayMedicines> createState() => _SelectedDayMedicinesState();
}

class MedicineSchedule {
  DateTime medicineTime;
  Medicine medicine;

  MedicineSchedule(this.medicineTime, this.medicine);
}

class _SelectedDayMedicinesState extends State<SelectedDayMedicines> {
  late DateTime selectedDay;

  @override
  void initState() {
    selectedDay = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<MedicineBloc>(context),
        builder: (context, state) {
          if (state is MedicineEmptyState) {
            return const Text('Não há Remédios');
          } else if (state is MedicineLoadedState) {
            List<MedicineSchedule> schedules = [];

            for (int i = 0; i < state.medicines.length; i++) {
              var medicine = state.medicines[i];
            }

            for (var medicine in state.medicines) {
              if ((medicine is DailyMedicine) ||
                  (medicine is WeeklyMedicine &&
                      medicine.initialDate.weekday == selectedDay.weekday)) {
                DateTime day = DateTime.utc(
                    selectedDay.year,
                    selectedDay.month,
                    selectedDay.day,
                    medicine.initialDate.hour,
                    medicine.initialDate.minute);
                schedules.add(MedicineSchedule(day, medicine));
              }
            }

            return Expanded(
              child: ListView.builder(
                itemCount: schedules.length,
                itemBuilder: ((context, index) {
                  MedicineSchedule medicine = schedules[index];
                  return Column(children: [
                    Text(
                        "${medicine.medicineTime.hour}:${medicine.medicineTime.minute}"),
                    Text("${medicine.medicine.name}")
                  ]);
                  // if (medicine is PeriodicMedicine) {
                  //   return periodicMedicinePreview(medicine);
                  // } else {
                  //   return standartMedicinePreview(medicine);
                  // }
                }),
              ),
            );
          } else {
            return const Text("Erro doido");
          }
        });
  }
}
