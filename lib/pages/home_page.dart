import 'package:app_medicine_scheduler/bloc/select_day_state.dart';
import 'package:app_medicine_scheduler/components/calendar.dart';
import 'package:app_medicine_scheduler/components/selected_day_medicines.dart';
import 'package:app_medicine_scheduler/pages/medicine_manager_page.dart';
import 'package:app_medicine_scheduler/pages/new_medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import '../bloc/select_day_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ' Remédiando',
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[
                        Colors.red.shade800,
                        Colors.red.shade300,
                        Colors.red.shade100
                      ],
                    ).createShader(
                      Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
                    ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (contextNew) => const MedicinesManagerPage(),
                  ),
                );
              },
              icon: IconTheme(
                data: IconThemeData(
                  color: Theme.of(context).iconTheme.color,
                ),
                child: const Icon(
                  Icons.manage_accounts_rounded,
                  size: 35,
                ),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 1, // Altura de 1 pixel para a linha
            color: Colors.transparent, // Define a cor transparente
          ),
          const MounthCalendar(),
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
        child: const Icon(
          Icons.medication_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
