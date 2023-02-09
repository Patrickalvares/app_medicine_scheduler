import 'package:app_medicine_scheduler/bloc/medicine_bloc.dart';
import 'package:app_medicine_scheduler/bloc/medicine_event.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class NewMedicine extends StatefulWidget {
  const NewMedicine({super.key});

  @override
  State<NewMedicine> createState() => _NewMedicineState();
}

class _NewMedicineState extends State<NewMedicine> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _medicineName = TextEditingController();
  final TextEditingController _medicineObservation = TextEditingController();
  final TextEditingController _periodicMedicineDays = TextEditingController();

  static const List<String> dropDownItems = [
    ' Diariamente',
    ' Semanalmente',
    ' Mensalmente',
    ' A cada __ dias',
    ' A cada __ horas',
  ];

  String? _recurrenceTypevalue;
  String? _medicineFrequencyType;
  late DateTime _timeInHours;

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 25),
        ),
      );
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
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8, top: 3, bottom: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Nome do Medicamento'),
                      border: OutlineInputBorder()),
                  controller: _medicineName,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8, top: 3, bottom: 20),
                child: Container(
                  alignment: Alignment.center,
                  height: 65,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade500),
                      borderRadius: BorderRadius.circular(4)),
                  child: DropdownButton<String>(
                    underline: const SizedBox(),
                    hint: const Text(
                      '  Qual a frequência de uso?',
                      style: TextStyle(fontSize: 22),
                    ),
                    items: dropDownItems.map(buildMenuItem).toList(),
                    onChanged: ((value) =>
                        setState(() => _recurrenceTypevalue = value)),
                    value: _recurrenceTypevalue,
                    isExpanded: true,
                  ),
                ),
              ),
              Visibility(
                visible: (_recurrenceTypevalue == ' A cada __ dias'),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 3, bottom: 20),
                  child: TextFormField(
                    validator: (value) {
                      if (int.tryParse(value!) is! int) {
                        return "Somente números";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        label: Text('Quantos dias:'),
                        border: OutlineInputBorder()),
                    controller: _periodicMedicineDays,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              Visibility(
                  visible: (_recurrenceTypevalue == ' A cada __ horas'),
                  child: TimePickerSpinner(
                    onTimeChange: (time) {
                      setState(() {
                        _timeInHours = time;
                      });
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8, top: 3, bottom: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Observação'), border: OutlineInputBorder()),
                  controller: _medicineObservation,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              Center(
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      late Medicine medicine;
                      switch (_recurrenceTypevalue) {
                        case ' Diariamente':
                          {
                            medicine = DailyMedicine(
                                _medicineName.text, DateTime.now());
                            break;
                          }
                        case ' Semanalmente':
                          {
                            medicine = WeeklyMedicine(
                                _medicineName.text, DateTime.now());
                            break;
                          }
                        case ' Mensalmente':
                          {
                            medicine = MonthlyMedicine(
                                _medicineName.text, DateTime.now());
                            break;
                          }
                        case ' A cada __ dias':
                          {
                            medicine = PeriodicMedicine(
                                _medicineName.text,
                                DateTime.now(),
                                Duration(
                                  days: int.parse(_periodicMedicineDays.text),
                                ));
                            break;
                          }
                        case ' A cada __ horas':
                          {
                            medicine = PeriodicMedicine(
                                _medicineName.text,
                                DateTime.now(),
                                Duration(
                                    hours: _timeInHours.hour,
                                    minutes: _timeInHours.minute));
                            break;
                          }
                        default:
                          throw Exception(
                              "Erro na seleção do tipo de Frequência");
                      }
                      BlocProvider.of<MedicineBloc>(context)
                          .add(AddMedicineEvent(medicine));
                      Navigator.pop(context);
                    }
                  },
                  label: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        Text(' Salvar'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
