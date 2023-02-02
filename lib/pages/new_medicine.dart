import 'package:app_medicine_scheduler/bloc/medicine_bloc.dart';
import 'package:app_medicine_scheduler/bloc/medicine_event.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewMedicine extends StatefulWidget {
  const NewMedicine({super.key});

  @override
  State<NewMedicine> createState() => _NewMedicineState();
}

class _NewMedicineState extends State<NewMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Adicionar Medicamento',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.manage_accounts_rounded,
                  color: Colors.black,
                  size: 35,
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                'Nome do Medicamento:',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8, top: 3, bottom: 20),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: TextFormField(
                  style: const TextStyle(fontSize: 25),
                ),
              ),
            ),
            Center(
              child: FloatingActionButton.extended(
                onPressed: () {
                  Medicine medicine =
                      Medicine('Test', DateTime.now(), RecurrenceType.daily);
                  BlocProvider.of<MedicineBloc>(context)
                      .add(AddMedicineEvent(medicine));
                },
                label: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    children: const [
                      Icon(Icons.save),
                      Text(' Salvar'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
