import 'package:app_medicine_scheduler/bloc/select_day_bloc.dart';
import 'package:app_medicine_scheduler/bloc/select_day_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MounthCalendar extends StatefulWidget {
  const MounthCalendar({super.key});

  @override
  State<MounthCalendar> createState() => _MounthCalendarState();
}

class _MounthCalendarState extends State<MounthCalendar> {
  DateTime _targetDayTime =
      DateTime.utc(DateTime.now().year, DateTime.now().month, 01);
  late DateTime selectDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    String targetMonthName = getMonthName(_targetDayTime.month);

    List<Widget> days = [
      buildWeekDaysNameHeader('Dom'),
      buildWeekDaysNameHeader('Seg'),
      buildWeekDaysNameHeader('Ter'),
      buildWeekDaysNameHeader('Qua'),
      buildWeekDaysNameHeader('Qui'),
      buildWeekDaysNameHeader('Sex'),
      buildWeekDaysNameHeader('Sab'),
    ];

    int daysToSkip =
        (_targetDayTime.weekday == 7) ? 0 : (_targetDayTime.weekday);
    days.addAll(buildEmptyDates(daysToSkip));
    int i = 0;
    do {
      if (plusOneDay(i) == selectDay.day.toString() &&
          _targetDayTime.month == selectDay.month &&
          _targetDayTime.year == selectDay.year) {
        days.add(buildSelectDayBlock(i));
        i++;
      } else if (plusOneDay(i) == DateTime.now().day.toString() &&
          _targetDayTime.month == DateTime.now().month &&
          _targetDayTime.year == DateTime.now().year) {
        days.add(buildCurrentDayBlock(i));
        i++;
      } else {
        days.add(buildNotCurrentDayBlock(i));
        i++;
      }
    } while (int.parse(plusOneDay(i)) > 1);

    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
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
                    '${_targetDayTime.year}',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        _targetDayTime = DateTime.utc(_targetDayTime.year,
                            _targetDayTime.month - 1, _targetDayTime.day);
                        setState(() {});
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_sharp)),
                  IconButton(
                      onPressed: () {
                        _targetDayTime = DateTime.utc(_targetDayTime.year,
                            _targetDayTime.month + 1, _targetDayTime.day);
                        setState(() {});
                      },
                      icon: const Icon(Icons.arrow_forward_ios_sharp)),
                  IconButton(
                      onPressed: () {
                        _targetDayTime = DateTime.utc(DateTime.now().year,
                            DateTime.now().month, _targetDayTime.day);
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

  Widget buildWeekDaysNameHeader(String weekDayName) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
            child: Text(weekDayName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white))));
  }

  List<Widget> buildEmptyDates(int p) {
    List<Widget> ret = [];
    for (int i = 0; i < p; i++) {
      ret.add(Container());
    }
    return ret;
  }

  String plusOneDay(int p) {
    String newDay = _targetDayTime.add(Duration(days: p)).day.toString();
    return newDay;
  }

  Widget buildCurrentDayBlock(int day) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: InkWell(
        onTap: () {
          BlocProvider.of<SelectDayBloc>(context).add(UpdateSelectDay(
              DateTime.utc(
                  _targetDayTime.year, _targetDayTime.month, day + 1)));
          setState(() {
            selectDay = DateTime.utc(
                _targetDayTime.year, _targetDayTime.month, day + 1);
          });
        },
        child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[600],
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
                child: Text(plusOneDay(day),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.white)))),
      ),
    );
  }

  Widget buildSelectDayBlock(int day) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: InkWell(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.grey),
            ),
            child: Center(
                child: Text(plusOneDay(day),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.white)))),
      ),
    );
  }

  Widget buildNotCurrentDayBlock(int day) {
    return InkWell(
      onTap: () {
        BlocProvider.of<SelectDayBloc>(context).add(UpdateSelectDay(
            DateTime.utc(_targetDayTime.year, _targetDayTime.month, day + 1)));
        setState(() {
          selectDay =
              DateTime.utc(_targetDayTime.year, _targetDayTime.month, day + 1);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            child: Center(child: Text(plusOneDay(day)))),
      ),
    );
  }

  String getMonthName(int month) {
    String name = '';
    switch (month) {
      case 1:
        name = 'Janeiro';
        break;
      case 2:
        name = 'Fevereiro';
        break;
      case 3:
        name = 'Março';
        break;
      case 4:
        name = 'Abril';
        break;
      case 5:
        name = 'Maio';
        break;
      case 6:
        name = 'Junho';
        break;
      case 7:
        name = 'Julho';
        break;
      case 8:
        name = 'Agosto';
        break;
      case 9:
        name = 'Setembro';
        break;
      case 10:
        name = 'Outubro';
        break;
      case 11:
        name = 'Novembro';
        break;
      case 12:
        name = 'Dezembro';
        break;
    }
    return name;
  }
}
