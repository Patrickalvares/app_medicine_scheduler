import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MounthCalendar extends StatefulWidget {
  const MounthCalendar({super.key});

  @override
  State<MounthCalendar> createState() => _MounthCalendarState();
}

class _MounthCalendarState extends State<MounthCalendar> {
  @override
  Widget build(BuildContext context) {
    int count = 1;
    DateTime dateTime = DateTime.utc(2023, 01, 01);
    List<Widget> days = [];

    for (int i = 0; i < 31; i++) {
      days.add(Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Center(child: Text('${dateTime.day + i}'))));
    }
    return Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: GridView.count(
          primary: false,
          crossAxisCount: 7,
          children: days,
        ));
  }
}
