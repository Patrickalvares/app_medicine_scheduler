import 'package:flutter/material.dart';

class MounthCalendar extends StatefulWidget {
  const MounthCalendar({super.key});

  @override
  State<MounthCalendar> createState() => _MounthCalendarState();
}

DateTime dateTime = DateTime.utc(2023, 07, 01);

class _MounthCalendarState extends State<MounthCalendar> {
  @override
  Widget build(BuildContext context) {
    String targetMonthName = "";
    int targetMonthNumber = dateTime.month;

    List<Widget> days = [
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: const Center(child: Text("Dom"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: const Center(child: Text("Seg"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: const Center(child: Text("Ter"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: const Center(child: Text("Qua"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: const Center(child: Text("Qui"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: const Center(child: Text("Sex"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: const Center(child: Text("Sab"))),
    ];

    switch (dateTime.weekday) {
      case 7:
        {
          for (int i = 0; i < 31; i++) {
            days.add(Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Center(
                    child: Text('${dateTime.add(Duration(days: i)).day}'))));
          }
        }
        break;

      case 1:
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        for (int i = 0; i < 31; i++) {
          days.add(Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(
                  child: Text('${dateTime.add(Duration(days: i)).day}'))));
        }
        break;
      case 2:
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        for (int i = 0; i < 31; i++) {
          days.add(Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(
                  child: Text('${dateTime.add(Duration(days: i)).day}'))));
        }
        break;
      case 3:
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        for (int i = 0; i < 31; i++) {
          days.add(Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(
                  child: Text('${dateTime.add(Duration(days: i)).day}'))));
        }
        break;
      case 4:
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        for (int i = 0; i < 31; i++) {
          days.add(Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(
                  child: Text('${dateTime.add(Duration(days: i)).day}'))));
        }
        break;
      case 5:
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        for (int i = 0; i < 31; i++) {
          days.add(Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(
                  child: Text('${dateTime.add(Duration(days: i)).day}'))));
        }
        break;
      case 6:
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        ));
        for (int i = 0; i < 31; i++) {
          days.add(Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Center(
                  child: Text('${dateTime.add(Duration(days: i)).day}'))));
        }
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
