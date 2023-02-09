import 'package:app_medicine_scheduler/bloc/medicine_bloc.dart';
import 'package:app_medicine_scheduler/bloc/medicine_state.dart';
import 'package:app_medicine_scheduler/components/calendar.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:app_medicine_scheduler/pages/new_medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              ' Remédiando',
              style: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.manage_accounts_rounded,
                  color: Colors.black,
                  size: 35,
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          const Flexible(child: MounthCalendar()),
          BlocBuilder(
              bloc: BlocProvider.of<MedicineBloc>(context),
              builder: (context, state) {
                if (state is MedicineEmptyState) {
                  return const Text('Não há Remédios');
                } else if (state is MedicineLoadedState) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.medicines.length,
                      itemBuilder: ((context, index) {
                        Medicine medicine = state.medicines[index];
                        if (medicine is PeriodicMedicine) {
                          return Row(
                            children: [
                              Text(medicine.name),
                              Text(
                                "${medicine.initialDate.day}/${medicine.initialDate.month}/${medicine.initialDate.year}",
                              ),
                              Text((medicine.active
                                  ? "O remédio está ativo"
                                  : "PAi tá off")),
                              Text(medicine.period.inHours.toString())
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Text(medicine.name),
                            Text(
                              "${medicine.initialDate.day}/${medicine.initialDate.month}/${medicine.initialDate.year}",
                            ),
                            Text((medicine.active
                                ? "O remédio está ativo"
                                : "PAi tá off"))
                          ],
                        );
                      }),
                    ),
                  );
                } else {
                  return const Text("Erro doido");
                }
              })
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contextNew) => const NewMedicine(),
            ),
          );
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.medication_rounded),
      ),
    );
  }
}
