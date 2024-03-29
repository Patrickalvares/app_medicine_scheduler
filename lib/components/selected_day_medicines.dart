import 'package:app_medicine_scheduler/bloc/medicine_bloc.dart';
import 'package:app_medicine_scheduler/bloc/medicine_event.dart';
import 'package:app_medicine_scheduler/bloc/medicine_state.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SelectedDayMedicines extends StatefulWidget {
  final DateTime selectedDay;
  const SelectedDayMedicines({super.key, required this.selectedDay});

  @override
  State<SelectedDayMedicines> createState() => _SelectedDayMedicinesState();
}

class MedicineSchedule {
  DateTime medicineTime;
  Medicine medicine;

  MedicineSchedule(this.medicineTime, this.medicine);
}

class _SelectedDayMedicinesState extends State<SelectedDayMedicines> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MedicineBloc>(context).add(FetchMedicineEvent());
  }

  bool checkLastMonthDayOverflow(Medicine medicine) {
    if (medicine.initialDate.day >
            DateTime.utc(
                    widget.selectedDay.year, widget.selectedDay.month + 1, 0)
                .day &&
        widget.selectedDay.day ==
            DateTime.utc(
                    widget.selectedDay.year, widget.selectedDay.month + 1, 0)
                .day) {
      return true;
    } else {
      return false;
    }
  }

  bool checkPeriodicPerDayInThisDay(PeriodicMedicine medicine) {
    DateTime iter = medicine.initialDate;
    do {
      iter = iter.add(medicine.period);

      if ((iter.day == widget.selectedDay.day) &&
          (iter.month == widget.selectedDay.month) &&
          (iter.year == widget.selectedDay.year)) {
        return true;
      }
    } while (iter.isBefore(widget.selectedDay));

    return false;
  }

  Color getMedicineColor(Medicine medicine) {
    if (medicine is DailyMedicine) {
      return Colors.green;
    } else if (medicine is WeeklyMedicine) {
      return Colors.blue;
    } else if (medicine is MonthlyMedicine) {
      return Colors.orange;
    } else {
      return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            BlocBuilder(
                bloc: BlocProvider.of<MedicineBloc>(context),
                builder: (context, state) {
                  if (state is MedicineEmptyState) {
                    return const Center(
                        child: Text(
                      'Não há Remédios',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ));
                  } else if (state is MedicineLoadedState) {
                    List<MedicineSchedule> schedules = [];
                    for (var medicine in state.medicines) {
                      if ((medicine is DailyMedicine) ||
                          (medicine is WeeklyMedicine &&
                              medicine.initialDate.weekday ==
                                  widget.selectedDay.weekday) ||
                          (medicine is MonthlyMedicine &&
                              (medicine.initialDate.day ==
                                      widget.selectedDay.day ||
                                  checkLastMonthDayOverflow(medicine)))) {
                        DateTime day = DateTime.utc(
                            widget.selectedDay.year,
                            widget.selectedDay.month,
                            widget.selectedDay.day,
                            medicine.initialDate.hour,
                            medicine.initialDate.minute);
                        schedules.add(MedicineSchedule(day, medicine));
                      } else if (medicine is PeriodicMedicine) {
                        DateTime iter = medicine.initialDate;
                        do {
                          if ((iter.day == widget.selectedDay.day) &&
                              (iter.month == widget.selectedDay.month) &&
                              (iter.year == widget.selectedDay.year)) {
                            DateTime day = DateTime.utc(
                                widget.selectedDay.year,
                                widget.selectedDay.month,
                                widget.selectedDay.day,
                                iter.hour,
                                iter.minute);
                            schedules.add(MedicineSchedule(day, medicine));
                          }
                          iter = iter.add(medicine.period);
                        } while (iter.isBefore(
                            widget.selectedDay.add(const Duration(days: 1))));
                      }
                    }
                    schedules.sort(
                        ((a, b) => a.medicineTime.compareTo(b.medicineTime)));
                    return Flexible(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: schedules.length,
                        itemBuilder: ((context, index) {
                          MedicineSchedule medicine = schedules[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 5, top: 5, left: 15, right: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 245, 150, 159),
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(medicine.medicine.name,
                                              style: TextStyle(
                                                  color: Colors.red.shade100,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              medicine.medicine.observation
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.red.shade100,
                                                  fontWeight: FontWeight.bold))
                                        ]),
                                    Text(
                                        "${medicine.medicine.periodicKind} ${DateFormat('HH:mm').format(medicine.medicineTime)}",
                                        style: TextStyle(
                                            color: Colors.red.shade100,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  } else {
                    return const Text(
                      "Erro doido",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
