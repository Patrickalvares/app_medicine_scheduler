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
  final FocusNode _medicineNameFocus = FocusNode();
  final FocusNode _dropdownFocus = FocusNode();
  final FocusNode _periodicMedicineDaysFocus = FocusNode();
  final FocusNode _medicineObservationFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _medicineNameFocus.addListener(_onFocusChange);
    _dropdownFocus.addListener(_onDropdownFocusChange);
    _periodicMedicineDaysFocus.addListener(_onFocusChange);
    _medicineObservationFocus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _medicineNameFocus.removeListener(_onFocusChange);
    _periodicMedicineDaysFocus.removeListener(_onFocusChange);
    _medicineNameFocus.dispose();
    _periodicMedicineDaysFocus.dispose();
    _dropdownFocus.removeListener(_onDropdownFocusChange);
    _dropdownFocus.dispose();
    _medicineObservationFocus.removeListener(_onFocusChange);
    _medicineObservationFocus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  void _onDropdownFocusChange() {
    setState(() {});
  }

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
    setState(() {});
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2999),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.red.shade100,
              onPrimary: Colors.black,
              surface: Colors.black,
              onSurface: Colors.red.shade100,
            ),
            dialogBackgroundColor: Colors.black,
          ),
          child: child!,
        );
      },
    );
    if (date == null) {
      return;
    }
    // ignore: use_build_context_synchronously
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 18, minute: 0),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.red.shade100,
              onPrimary: Colors.black,
              surface: Colors.black,
              onSurface: Colors.red.shade100,
            ),
            dialogBackgroundColor: Colors.black,
          ),
          child: child!,
        );
      },
    );
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
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: MyApp.appGradient,
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                const Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 8,
                    top: 10,
                  ),
                  child: Text(
                    'Nome do Medicamento:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 8, bottom: 10),
                  child: TextFormField(
                    maxLength: 40,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira um Nome";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      counterText: "",
                      fillColor: Colors.black,
                      filled: true,
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    controller: _medicineName,
                    focusNode: _medicineNameFocus,
                    style: TextStyle(fontSize: 22, color: Colors.red.shade100),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 8, top: 10),
                  child: Text('Frequência de uso:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 3, bottom: 20),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(
                          color: _dropdownFocus.hasFocus
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Escolha a Frequência';
                      }
                      return null;
                    },
                    focusNode: _dropdownFocus,
                    items: dropDownItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: Colors.red.shade100,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: ((value) =>
                        setState(() => _recurrenceTypevalue = value)),
                    value: _recurrenceTypevalue,
                    isExpanded: true,
                    dropdownColor: Colors.black,
                    iconEnabledColor: Colors.red.shade100,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Visibility(
                    visible: (_recurrenceTypevalue == ' A cada __ dias'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 8,
                          ),
                          child: Text('Quantos dias:',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ),
                        Padding(
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
                            decoration: InputDecoration(
                              fillColor: Colors.black,
                              filled: true,
                              border: const OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            controller: _periodicMedicineDays,
                            focusNode: _periodicMedicineDaysFocus,
                            style: TextStyle(
                                fontSize: 22, color: Colors.red.shade100),
                          ),
                        ),
                      ],
                    )),
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
                const Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 8,
                  ),
                  child: Text('Dia e Hora Inicial:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
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
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    controller: _initialDate,
                    style: TextStyle(
                        color: Colors.red.shade100,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 8),
                  child: Text('Observação:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 3, bottom: 20),
                  child: TextFormField(
                    maxLength: 200,
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                    controller: _medicineObservation,
                    focusNode: _medicineObservationFocus,
                    style: TextStyle(fontSize: 22, color: Colors.red.shade100),
                  ),
                ),
                Center(
                  child: FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(36),
                        side: BorderSide(color: Colors.red.shade100)),
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
                        children: [
                          Icon(
                            Icons.save,
                            color: Colors.red.shade100,
                          ),
                          Text(
                            ' Salvar',
                            style: TextStyle(color: Colors.red.shade100),
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
