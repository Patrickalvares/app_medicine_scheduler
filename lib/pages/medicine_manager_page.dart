import 'package:app_medicine_scheduler/bloc/medicine_bloc.dart';
import 'package:app_medicine_scheduler/bloc/medicine_event.dart';
import 'package:app_medicine_scheduler/bloc/medicine_state.dart';
import 'package:app_medicine_scheduler/components/selected_day_medicines.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicinesManagerPage extends StatefulWidget {
  const MedicinesManagerPage({super.key});

  @override
  State<MedicinesManagerPage> createState() => _MedicinesManagerPageState();
}

class _MedicinesManagerPageState extends State<MedicinesManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Gerenciar Medicamento',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
          ],
        ),
      ),
      body: BlocBuilder(
          bloc: BlocProvider.of<MedicineBloc>(context),
          builder: (context, state) {
            if (state is MedicineEmptyState) {
              return const Center(child: Text('Não há Remédios'));
            } else if (state is MedicineLoadedState) {
              List<MedicineSchedule> schedules = [];

              for (var medicine in state.medicines) {
                if ((medicine is DailyMedicine) ||
                    (medicine is WeeklyMedicine) ||
                    (medicine is MonthlyMedicine) ||
                    (medicine is PeriodicMedicine)) {
                  DateTime day = DateTime.now();
                  schedules.add(MedicineSchedule(day, medicine));
                }
              }

              return ListView.builder(
                itemCount: schedules.length,
                itemBuilder: ((context, index) {
                  MedicineSchedule medicine = schedules[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: 5, top: 5, left: 10, right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(medicine.medicine.name),
                                  Text(medicine.medicine.observation.toString())
                                ]),
                            Text(
                                "${medicine.medicine.periodicKind} ${medicine.medicineTime.hour}:${medicine.medicineTime.minute}"),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirmação'),
                                      content: const Text(
                                          'Tem certeza que deseja deletar?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              context, 'Cancelar'),
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              BlocProvider.of<MedicineBloc>(
                                                      context)
                                                  .add(RemoveMedicineEvent(
                                                      medicine.medicine)),
                                          child: const Text('Deletar'),
                                        ),
                                      ],
                                    );
                                  },
                                ).then((value) {
                                  if (value == 'Deletar') {}
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else {
              return const Text("Erro doido");
            }
          }),
    );
  }
}
