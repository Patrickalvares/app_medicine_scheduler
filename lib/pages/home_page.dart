import 'package:app_medicine_scheduler/components/calendar.dart';
import 'package:flutter/material.dart';

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
      body: const MounthCalendar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(Icons.medication_rounded),
      ),
    );
  }
}
