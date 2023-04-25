import 'package:app_medicine_scheduler/bloc/medicine_bloc.dart';
import 'package:app_medicine_scheduler/bloc/medicine_event.dart';
import 'package:app_medicine_scheduler/bloc/medicine_state.dart';
import 'package:app_medicine_scheduler/components/selected_day_medicines.dart';
import 'package:app_medicine_scheduler/main.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:app_medicine_scheduler/pages/edit_medicine_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MedicinesManagerPage extends StatefulWidget {
  const MedicinesManagerPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MedicinesManagerPage> createState() => _MedicinesManagerPageState();
}

class _MedicinesManagerPageState extends State<MedicinesManagerPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: MyApp.appGradient,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Gerenciar Medicamentos',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 23),
                ),
              ],
            ),
          ),
          body: BlocBuilder(
              bloc: BlocProvider.of<MedicineBloc>(context),
              builder: (context, state) {
                if (state is MedicineEmptyState) {
                  return const Center(child: Text('Não há Remédios'));
                } else if (state is MedicineLoadedState) {
                  List<MedicineSchedule> schedules = [];

                  for (var medicine in state.medicines) {
                    if ((medicine is DailyMedicine) ||
                        (medicine is WeeklyMedicine) ||
                        (medicine is MonthlyMedicine) ||
                        (medicine is PeriodicMedicine)) {
                      DateTime day = DateTime.now();
                      schedules.add(MedicineSchedule(day, medicine));
                    }
                  }

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: schedules.length,
                    itemBuilder: ((context, index) {
                      MedicineSchedule medicine = schedules[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 5, top: 5, left: 10, right: 10),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            textTheme: Theme.of(context).textTheme.apply(
                                  bodyColor: Colors.red.shade100,
                                  displayColor: Colors.red.shade100,
                                ),
                            iconTheme: Theme.of(context).iconTheme.copyWith(
                                  color: Colors.red.shade100,
                                ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(color: Colors.red.shade100),
                                borderRadius: BorderRadius.circular(8)),
                            child: ExpansionTile(
                              collapsedTextColor: Colors.red.shade100,
                              iconColor: Colors.red.shade100,
                              collapsedIconColor: Colors.red.shade100,
                              textColor: Colors.red.shade100,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(medicine.medicine.name),
                                          ]),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(DateFormat('HH:mm').format(
                                            medicine.medicine.initialDate)),
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red.shade100,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return FadeTransition(
                                                    opacity: _animation,
                                                    child: AlertDialog(
                                                      backgroundColor:
                                                          Colors.black,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        side: BorderSide(
                                                            color: Colors
                                                                .red.shade100,
                                                            width: 2),
                                                      ),
                                                      title: Text(
                                                        'Confirmação',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red.shade100),
                                                      ),
                                                      content: Text(
                                                        'Tem certeza que deseja deletar?',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .red.shade100),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'Cancelar'),
                                                          child: Text(
                                                            'Cancelar',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red
                                                                    .shade100),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            BlocProvider.of<
                                                                        MedicineBloc>(
                                                                    context)
                                                                .add(
                                                              RemoveMedicineEvent(
                                                                  medicine
                                                                      .medicine),
                                                            );
                                                            Navigator.pop(
                                                                context,
                                                                'Deletar');
                                                          },
                                                          child: Text(
                                                            'Deletar',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red
                                                                    .shade100),
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              },
                                            );
                                          },
                                        ),
                                        IconButton(
                                          icon: AnimatedSwitcher(
                                            duration: const Duration(
                                                milliseconds: 2000),
                                            child: Icon(
                                              Icons.edit_note_rounded,
                                              color: Colors.red.shade100,
                                              key: const ValueKey(
                                                'edit_icon',
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    EditMedicine(
                                                        medicine.medicine),
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  return FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 8, left: 8),
                                        child: RichText(
                                          text: TextSpan(
                                            style: const TextStyle(
                                              color: Colors.black,
                                            ),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Tipo Periódico:',
                                                style: TextStyle(
                                                  color: Colors.red.shade100,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              TextSpan(
                                                  text:
                                                      ' ${medicine.medicine.periodicKind}',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.red.shade100)),
                                            ],
                                          ),
                                        )),
                                    medicine.medicine.observation != ''
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: RichText(
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: 'Observação:',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .red.shade100),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          ' ${medicine.medicine.observation}',
                                                      style: TextStyle(
                                                        color:
                                                            Colors.red.shade100,
                                                      )),
                                                ],
                                              ),
                                            ))
                                        : const Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: SizedBox(),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                } else {
                  return const Text("Erro doido");
                }
              }),
        ));
  }
}
