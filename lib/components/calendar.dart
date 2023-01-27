import 'package:flutter/material.dart';

class MounthCalendar extends StatefulWidget {
  const MounthCalendar({super.key});

  @override
  State<MounthCalendar> createState() => _MounthCalendarState();
}

DateTime dateTime = DateTime.utc(2023, 01, 01);
int targetMonthNumber = 0;

class _MounthCalendarState extends State<MounthCalendar> {
  @override
  Widget build(BuildContext context) {
    String targetMonthName = "";

    Widget weekDaysNameHeader(String weekDayName) {
      return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
              child: Text(weekDayName,
                  style: const TextStyle(fontWeight: FontWeight.bold))));
    }

    List<Widget> days = [
      weekDaysNameHeader('Dom'),
      weekDaysNameHeader('Seg'),
      weekDaysNameHeader('Ter'),
      weekDaysNameHeader('Qua'),
      weekDaysNameHeader('Qui'),
      weekDaysNameHeader('Sex'),
      weekDaysNameHeader('Sab'),
    ];

    void emptyDate(int p) {
      for (int i = 0; i < p; i++) {
        days.add(Container());
      }
    }

    String plusOneDay(int p) {
      String newDay = dateTime.add(Duration(days: p)).day.toString();
      return newDay;
    }

    void daysDraw(int position) {
      emptyDate(position);
      int i = 0;
      do {
        days.add(Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(plusOneDay(i)))));
        i++;
      } while (int.parse(plusOneDay(i)) > 1);
    }

    switch (dateTime.weekday) {
      case 7:
        daysDraw(0);
        break;
      case 1:
        daysDraw(1);
        break;
      case 2:
        daysDraw(2);
        break;
      case 3:
        daysDraw(3);
        break;
      case 4:
        daysDraw(4);
        break;
      case 5:
        daysDraw(5);
        break;
      case 6:
        daysDraw(6);
        break;
    }

    switch (dateTime.month) {
      case 1:
        targetMonthName = 'Janeiro';
        break;
    }
    switch (dateTime.month) {
      case 2:
        targetMonthName = 'Fevereiro';
        break;
    }
    switch (dateTime.month) {
      case 3:
        targetMonthName = 'Março';
        break;
    }
    switch (dateTime.month) {
      case 4:
        targetMonthName = 'Abril';
        break;
    }
    switch (dateTime.month) {
      case 5:
        targetMonthName = 'Maio';
        break;
    }
    switch (dateTime.month) {
      case 6:
        targetMonthName = 'Junho';
        break;
    }
    switch (dateTime.month) {
      case 7:
        targetMonthName = 'Julho';
        break;
    }
    switch (dateTime.month) {
      case 8:
        targetMonthName = 'Agosto';
        break;
    }
    switch (dateTime.month) {
      case 9:
        targetMonthName = 'Setembro';
        break;
    }
    switch (dateTime.month) {
      case 10:
        targetMonthName = 'Outubro';
        break;
    }
    switch (dateTime.month) {
      case 11:
        targetMonthName = 'Novembro';
        break;
    }
    switch (dateTime.month) {
      case 12:
        targetMonthName = 'Dezembro';
        break;
    }

    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    targetMonthName,
                    style: const TextStyle(fontSize: 25),
                  ),
                  Text(
                    '${dateTime.year}',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        dateTime = DateTime.utc(
                            dateTime.year, dateTime.month - 1, dateTime.day);
                        setState(() {});
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_sharp)),
                  IconButton(
                      onPressed: () {
                        dateTime = DateTime.utc(
                            dateTime.year, dateTime.month + 1, dateTime.day);
                        setState(() {});
                      },
                      icon: const Icon(Icons.arrow_forward_ios_sharp)),
                  IconButton(
                      onPressed: () {
                        dateTime = DateTime.utc(DateTime.now().year,
                            DateTime.now().month, dateTime.day);
                        setState(() {});
                      },
                      icon: const Icon(Icons.replay_outlined)),
                ],
              ),
            ],
          ),
          Flexible(
            child: GridView.count(
              primary: false,
              crossAxisCount: 7,
              children: days,
            ),
          ),
        ],
      ),
    );
  }
}
