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

class _MedicinesManagerPageState extends State<MedicinesManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
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
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(8)),
                          child: ExpansionTile(
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
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Confirmação'),
                                                content: const Text(
                                                    'Tem certeza que deseja deletar?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(context,
                                                            'Cancelar'),
                                                    child:
                                                        const Text('Cancelar'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  MedicineBloc>(
                                                              context)
                                                          .add(
                                                        RemoveMedicineEvent(
                                                          medicine.medicine,
                                                        ),
                                                      );
                                                      Navigator.pop(
                                                          context, 'Deletar');
                                                    },
                                                    child:
                                                        const Text('Deletar'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon:
                                            const Icon(Icons.edit_note_rounded),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (contextNew) =>
                                                  EditMedicine(
                                                      medicine.medicine),
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                            const TextSpan(
                                              text: 'Tipo Periódico:',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' ${medicine.medicine.periodicKind}',
                                            ),
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
                                                const TextSpan(
                                                  text: 'Observação:',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      ' ${medicine.medicine.observation}',
                                                ),
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
