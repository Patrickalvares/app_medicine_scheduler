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
        backgroundColor: Colors.red.shade200,
        appBar: AppBar(
          title: Text('Remédiando'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            color: Colors.amber,
            child: TableCalendar(
              calendarFormat: calendarFormat,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Mês',
                CalendarFormat.week: 'Semana'
              },
              onFormatChanged: (format) {
                setState(() {
                  calendarFormat = format;
                });
              },
              locale: 'pt_BR',
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            ),
          ),
        ));
  }
}
