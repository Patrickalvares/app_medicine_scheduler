import 'package:flutter/material.dart';

class MounthCalendar extends StatefulWidget {
  const MounthCalendar({super.key});

  @override
  State<MounthCalendar> createState() => _MounthCalendarState();
}

DateTime dateTime = DateTime.utc(2023, 07, 01);
int targetMonthNumber = 0;

class _MounthCalendarState extends State<MounthCalendar> {
  @override
  Widget build(BuildContext context) {
    String targetMonthName = "";

    List<Widget> days = [
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
          child: const Center(
              child:
                  Text("Dom", style: TextStyle(fontWeight: FontWeight.bold)))),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
          child: const Center(
              child:
                  Text("Seg", style: TextStyle(fontWeight: FontWeight.bold)))),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
          child: const Center(
              child:
                  Text("Ter", style: TextStyle(fontWeight: FontWeight.bold)))),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
          child: const Center(
              child:
                  Text("Qua", style: TextStyle(fontWeight: FontWeight.bold)))),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
          child: const Center(
              child:
                  Text("Qui", style: TextStyle(fontWeight: FontWeight.bold)))),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
          child: const Center(
              child: Text(
            "Sex",
            style: TextStyle(fontWeight: FontWeight.bold),
          ))),
      Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
          child: const Center(
              child: Text(
            "Sab",
            style: TextStyle(fontWeight: FontWeight.bold),
          ))),
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
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                targetMonthName,
                style: const TextStyle(fontSize: 25),
              ),
              Text(
                '${dateTime.year}',
                style: const TextStyle(fontSize: 25),
              ),
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
