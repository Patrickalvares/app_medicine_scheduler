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
    DateTime dateTime = DateTime.utc(2023, 03, 01);
    List<Widget> days = [
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Center(child: Text("Dom"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Center(child: Text("Seg"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Center(child: Text("Ter"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Center(child: Text("Qua"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Center(child: Text("Qui"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Center(child: Text("Sex"))),
      Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Center(child: Text("Sab"))),
    ];

    switch (dateTime.weekday) {
      case 7:
        {
          for (int i = 0; i < 31; i++) {
            days.add(Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Center(child: Text('${dateTime.day + i}'))));
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
              child: Center(child: Text('${dateTime.day + i}'))));
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
              child: Center(child: Text('${dateTime.day + i}'))));
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
              child: Center(child: Text('${dateTime.day + i}'))));
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
              child: Center(child: Text('${dateTime.day + i}'))));
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
              child: Center(child: Text('${dateTime.day + i}'))));
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
              child: Center(child: Text('${dateTime.day + i}'))));
        }
        break;
    }

    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: GridView.count(
        primary: false,
        crossAxisCount: 7,
        children: days,
      ),
    );
  }
}
