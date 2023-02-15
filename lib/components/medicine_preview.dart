import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:flutter/material.dart';

Widget periodicMedicinePreview(medicine) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(medicine.name),
                Text(
                  "${medicine.initialDate.day}/${medicine.initialDate.month}/${medicine.initialDate.year}",
                ),
              ],
            ),
            Text((medicine.active ? "Ativo" : "Inativo")),
            Column(
              children: [
                Text('${medicine.period.inHours.toString()} Horas'),
                Text('${medicine.period.inDays.toString()} Dias'),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget standartMedicinePreview(medicine) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(medicine.name),
                Text(
                  "${medicine.initialDate.day}/${medicine.initialDate.month}/${medicine.initialDate.year}",
                ),
              ],
            ),
            Text((medicine.active ? "Ativo" : "Inativo")),
            if (medicine is DailyMedicine) ...[
              const Text('Diariamente')
            ] else if (medicine is WeeklyMedicine) ...[
              const Text('Semanalmente')
            ] else if (medicine is MonthlyMedicine) ...[
              const Text('Mensalmente')
            ]
          ],
        ),
      ),
    ),
  );
}
