import 'package:app_medicine_scheduler/bloc/medicine_bloc.dart';
import 'package:app_medicine_scheduler/bloc/medicine_event.dart';
import 'package:app_medicine_scheduler/bloc/select_day_state.dart';
import 'package:app_medicine_scheduler/components/calendar.dart';
import 'package:app_medicine_scheduler/components/selected_day_medicines.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:app_medicine_scheduler/pages/new_medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../bloc/select_day_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MedicineBloc>(context).add(AddMedicineEvent(MonthlyMedicine(
        'Viagra', DateTime.utc(2023, 03, 31, 22, 15),
        observation: 'Azulzinho')));
    BlocProvider.of<MedicineBloc>(context).add(AddMedicineEvent(DailyMedicine(
        'Tilenol', DateTime.utc(2023, 02, 07, 21, 15),
        observation: 'Dor de cabeça')));
    BlocProvider.of<MedicineBloc>(context).add(AddMedicineEvent(WeeklyMedicine(
        'Doril', DateTime.utc(2023, 02, 22, 22, 15),
        observation: 'A dor sumio')));
    BlocProvider.of<MedicineBloc>(context).add(AddMedicineEvent(
        PeriodicMedicine('Cloroquina', DateTime.utc(2023, 02, 05, 22, 15),
            const Duration(days: 5),
            observation: 'Faz arminha com a Mão')));
    BlocProvider.of<MedicineBloc>(context).add(
      AddMedicineEvent(
        PeriodicMedicine('Ritalina', DateTime.utc(2023, 02, 05, 22, 15),
            const Duration(hours: 15),
            observation: 'Pra doido'),
      ),
    );
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
            bloc: BlocProvider.of<SelectDayBloc>(context),
            builder: (context, state) {
              if (state is SelectDayLoadedState) {
                return SelectedDayMedicines(
                  selectedDay: state.selectDay,
                );
              } else {
                return const SizedBox();
              }
            },
          )
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
