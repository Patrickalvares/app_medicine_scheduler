import 'dart:math';

import 'package:app_medicine_scheduler/bloc/select_day_bloc.dart';
import 'package:app_medicine_scheduler/bloc/select_day_event.dart';
import 'package:app_medicine_scheduler/tools/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MounthCalendar extends StatefulWidget {
  const MounthCalendar({super.key});

  @override
  State<MounthCalendar> createState() => _MounthCalendarState();
}

class _MounthCalendarState extends State<MounthCalendar>
    with TickerProviderStateMixin {
  DateTime _targetDayTime =
      DateTime.utc(DateTime.now().year, DateTime.now().month, 01);
  late DateTime selectDay = DateTime.now();
  late AnimationController _animationController;
  late AnimationController _leftArrowAnimationController;
  late AnimationController _rightArrowAnimationController;
  late AnimationController _rotateArrowAnimationController;

  int previousMonth = DateTime.now().month;
  int _currentTransitionDirection = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _leftArrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _rightArrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _rotateArrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onLeftArrowPressed() {
    updateTargetDayTime(-1);
    _leftArrowAnimationController.forward(from: 0);
  }

  void onRightArrowPressed() {
    updateTargetDayTime(1);
    _rightArrowAnimationController.forward(from: 0);
  }

  void onRotateArrowPressed() async {
    await NotificationManager.showPeriodicLocalNotification(
      id: 1,
      title: "Drink Water",
      body: "Time to drink some water!",
      payload: "You just took water! Huurray!",
    );

    _targetDayTime = DateTime.utc(
        DateTime.now().year, DateTime.now().month, _targetDayTime.day);
    setState(() {});
    _rotateArrowAnimationController.forward(from: 0);
  }

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
      Color? backgroundColor;
      Color textColor = Theme.of(context).textTheme.bodyLarge!.color!;

      if (isSelectDay(i)) {
        backgroundColor = Theme.of(context).primaryColor;
        textColor = Colors.white;
      } else if (isToday(i)) {
        backgroundColor = const Color.fromARGB(255, 0, 0, 0);
        textColor = Colors.red.shade100;
      }

      days.add(buildDayContainer(i, backgroundColor, textColor));
      i++;
    } while (int.parse(plusOneDay(i)) > 1);

    return SizedBox(
      height: 430,
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            updateTargetDayTime(-1);
          } else if (details.primaryVelocity! < 0) {
            updateTargetDayTime(1);
          }
        },
        child: Container(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 5,
          ),
          decoration: const BoxDecoration(
            border: null,
          ),
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
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '${_targetDayTime.year}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      AnimatedBuilder(
                        animation: _leftArrowAnimationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                TweenSequence<double>([
                                  TweenSequenceItem<double>(
                                    tween: Tween<double>(begin: 0, end: -10),
                                    weight: 50,
                                  ),
                                  TweenSequenceItem<double>(
                                    tween: Tween<double>(begin: -10, end: 0),
                                    weight: 50,
                                  ),
                                ]).evaluate(_leftArrowAnimationController),
                                0),
                            child: child,
                          );
                        },
                        child: IconButton(
                          onPressed: onLeftArrowPressed,
                          icon: const Icon(Icons.arrow_back_ios_sharp),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _rightArrowAnimationController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                                TweenSequence<double>([
                                  TweenSequenceItem<double>(
                                    tween: Tween<double>(begin: 0, end: 10),
                                    weight: 50,
                                  ),
                                  TweenSequenceItem<double>(
                                    tween: Tween<double>(begin: 10, end: 0),
                                    weight: 50,
                                  ),
                                ]).evaluate(_rightArrowAnimationController),
                                0),
                            child: child,
                          );
                        },
                        child: IconButton(
                          onPressed: onRightArrowPressed,
                          icon: const Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: _rotateArrowAnimationController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle:
                                -2 * pi * _rotateArrowAnimationController.value,
                            child: child,
                          );
                        },
                        child: IconButton(
                          onPressed: onRotateArrowPressed,
                          icon: const Icon(Icons.replay_outlined),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Flexible(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 800),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    Offset beginOffset =
                        getTransitionBeginOffset(_currentTransitionDirection);
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: beginOffset, end: const Offset(0.0, 0.0))
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: GridView.count(
                    key: ValueKey<int>(_targetDayTime.month),
                    primary: false,
                    crossAxisCount: 7,
                    children: days,
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(color: Colors.red.shade100)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 12, left: 12),
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(selectDay),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red.shade100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Offset getTransitionBeginOffset(int direction) {
    if (direction == -1) {
      if (previousMonth > _targetDayTime.month) {
        return const Offset(2.5, 0.0);
      } else {
        return const Offset(2.5, 0.0);
      }
    } else {
      if (previousMonth < _targetDayTime.month) {
        return const Offset(-2.5, 0.0);
      } else {
        return const Offset(-2.5, 0.0);
      }
    }
  }

  void updateTargetDayTime(int direction) {
    previousMonth = _targetDayTime.month;
    _targetDayTime = DateTime.utc(_targetDayTime.year,
        _targetDayTime.month + direction, _targetDayTime.day);
    _currentTransitionDirection = direction;
    setState(() {});
  }

  int getTransitionDirection(int direction) {
    return direction == 1 ? -1 : 1;
  }

  Widget buildWeekDaysNameHeader(String weekDayName) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.black),
        ),
        child: Center(
            child: Text(weekDayName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red.shade100))));
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

  bool isSelectDay(int day) {
    return plusOneDay(day) == selectDay.day.toString() &&
        _targetDayTime.month == selectDay.month &&
        _targetDayTime.year == selectDay.year;
  }

  bool isToday(int day) {
    return plusOneDay(day) == DateTime.now().day.toString() &&
        _targetDayTime.month == DateTime.now().month &&
        _targetDayTime.year == DateTime.now().year;
  }

  Widget buildDayContainer(int day, Color? backgroundColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: InkWell(
        onTap: () {
          updateSelectedDay(day);
        },
        child: AnimatedScale(
          scale: isSelectDay(day) ? 1.1 : 1.0,
          curve: Curves.easeInOut,
          duration: _animationController.duration!,
          child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                  child: Text(plusOneDay(day),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: textColor)))),
        ),
      ),
    );
  }

  void updateSelectedDay(int day) {
    _animationController.forward(from: 0).then((value) {
      BlocProvider.of<SelectDayBloc>(context).add(UpdateSelectDay(
          DateTime.utc(_targetDayTime.year, _targetDayTime.month, day + 1)));
      setState(() {
        selectDay =
            DateTime.utc(_targetDayTime.year, _targetDayTime.month, day + 1);
      });
    });
  }

  bool has31Days() {
    int month = _targetDayTime.month;
    int year = _targetDayTime.year;
    return (month <= 7 && month % 2 == 1) ||
        (month >= 8 && month % 2 == 0) ||
        (month == 2 && isLeapYear(year));
  }

  bool isLeapYear(int year) {
    return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
      default:
        return 'Erro';
    }
  }
}
