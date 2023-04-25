import 'dart:math';

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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  CalendarFormat calendarFormat = CalendarFormat.month;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Colors.red.shade800,
                        Colors.red.shade300,
                        Colors.red.shade100
                      ],
                    ).createShader(
                      const Rect.fromLTWH(0.0, 0.0, 300.0, 100.0),
                    ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                _controller.forward().then((_) {
                  _controller.reverse();
                  Navigator.push(
                    context,
                    _createRouteMedicinesManagerPage(),
                  );
                });
              },
              icon: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final angle = (_controller.value * 0.1) *
                      (sin(_controller.value * pi) * 6);
                  return Transform.rotate(
                    angle: angle,
                    child: child,
                  );
                },
                child: IconTheme(
                  data: IconThemeData(
                    color: Theme.of(context).iconTheme.color,
                  ),
                  child: const Icon(
                    Icons.manage_accounts_rounded,
                    size: 35,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 1,
            color: Colors.transparent,
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
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
            side: BorderSide(color: Colors.red.shade100)),
        onPressed: () {
          _controller.forward().then((_) {
            _controller.reverse();
            Navigator.push(
              context,
              _createRouteNewMedicine(),
            );
          });
        },
        backgroundColor: Colors.black,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final angle =
                (_controller.value * 0.3) * (sin(_controller.value * pi) * 2);
            return Transform.rotate(
              angle: angle,
              child: child,
            );
          },
          child: const Icon(
            Icons.medication_rounded,
            color: Color.fromARGB(255, 245, 150, 159),
            size: 35,
          ),
        ),
      ),
    );
  }
}

Route _createRouteNewMedicine() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const NewMedicine(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

Route _createRouteMedicinesManagerPage() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const MedicinesManagerPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
