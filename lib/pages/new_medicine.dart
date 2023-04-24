import 'package:app_medicine_scheduler/bloc/medicine_bloc.dart';
import 'package:app_medicine_scheduler/bloc/medicine_event.dart';
import 'package:app_medicine_scheduler/main.dart';
import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

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
  final TextEditingController _initialDate = TextEditingController();
  static const List<String> dropDownItems = [
    ' Diariamente',
    ' Semanalmente',
    ' Mensalmente',
    ' A cada __ dias',
    ' A cada __ horas',
  ];

  Future _openInitialDatePicker() async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2999));
    if (date == null) {
      return;
    }
    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 18, minute: 0),
        initialEntryMode: TimePickerEntryMode.input);
    if (time == null) {
      return;
    }
    String dateString =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    String timeString =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    _initialDate.text = '$dateString $timeString';
  }

  String? _recurrenceTypevalue;
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
    ThemeData themeData = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: MyApp.appGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Adicionar Medicamento',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
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
                    maxLength: 40,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira um Nome";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                        counterText: "",
                        label: Text('Nome do Medicamento'),
                        border: OutlineInputBorder()),
                    controller: _medicineName,
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 3, bottom: 20),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Escolha a Frequência';
                      }
                      return null;
                    },
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
                      isForce2Digits: true,
                      time: DateTime(0, 0, 0, 12, 0),
                      minutesInterval: 5,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Selecione Data e Hora';
                      }
                      return null;
                    },
                    onTap: _openInitialDatePicker,
                    enableSuggestions: true,
                    cursorHeight: 34,
                    readOnly: true,
                    decoration: const InputDecoration(
                        label: Text(
                          'Dia e Hora Inicial',
                          style: TextStyle(fontSize: 22),
                        ),
                        border: OutlineInputBorder()),
                    controller: _initialDate,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 3, bottom: 20),
                  child: TextFormField(
                    maxLength: 200,
                    decoration: const InputDecoration(
                        label: Text('Observação'),
                        border: OutlineInputBorder()),
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
                                  DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  _medicineName.text,
                                  DateFormat('dd/MM/yyyy HH:mm')
                                      .parse(_initialDate.text),
                                  observation: _medicineObservation.text);
                              break;
                            }
                          case ' Semanalmente':
                            {
                              medicine = WeeklyMedicine(
                                  DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  _medicineName.text,
                                  DateFormat('dd/MM/yyyy HH:mm')
                                      .parse(_initialDate.text),
                                  observation: _medicineObservation.text);
                              break;
                            }
                          case ' Mensalmente':
                            {
                              medicine = MonthlyMedicine(
                                  DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  _medicineName.text,
                                  DateFormat('dd/MM/yyyy HH:mm')
                                      .parse(_initialDate.text),
                                  observation: _medicineObservation.text);
                              break;
                            }
                          case ' A cada __ dias':
                            {
                              medicine = PeriodicMedicine(
                                  DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  _medicineName.text,
                                  DateFormat('dd/MM/yyyy HH:mm')
                                      .parse(_initialDate.text),
                                  Duration(
                                    days: int.parse(_periodicMedicineDays.text),
                                  ),
                                  observation: _medicineObservation.text);
                              break;
                            }
                          case ' A cada __ horas':
                            {
                              medicine = PeriodicMedicine(
                                  DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  _medicineName.text,
                                  DateFormat('dd/MM/yyyy HH:mm')
                                      .parse(_initialDate.text),
                                  Duration(
                                      hours: _timeInHours.hour,
                                      minutes: _timeInHours.minute),
                                  observation: _medicineObservation.text);
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
                          Text(
                            ' Salvar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
