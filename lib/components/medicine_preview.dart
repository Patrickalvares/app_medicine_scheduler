import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:flutter/material.dart';

Widget periodicMedicinePreview(PeriodicMedicine medicine) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                medicine.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Icon(
                medicine.active ? Icons.check_circle : Icons.cancel,
                color: medicine.active ? Colors.green : Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 5),
              Text(
                "${medicine.initialDate.day}/${medicine.initialDate.month}/${medicine.initialDate.year}",
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.timer),
              const SizedBox(width: 5),
              Text('${medicine.period.inHours.toString()} Horas'),
              const Text(' | '),
              Text('${medicine.period.inDays.toString()} Dias'),
            ],
          ),
          if (medicine.observation?.isNotEmpty ?? false) ...[
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.comment),
                const SizedBox(width: 5),
                Expanded(child: Text(medicine.observation.toString())),
              ],
            )
          ]
        ],
      ),
    ),
  );
}

Widget standardMedicinePreview(Medicine medicine) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                medicine.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Icon(
                medicine.active ? Icons.check_circle : Icons.cancel,
                color: medicine.active ? Colors.green : Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 5),
              Text(
                "${medicine.initialDate.day}/${medicine.initialDate.month}/${medicine.initialDate.year}",
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.repeat),
              const SizedBox(width: 5),
              if (medicine is DailyMedicine) ...[
                const Text('Diariamente')
              ] else if (medicine is WeeklyMedicine) ...[
                const Text('Semanalmente')
              ] else if (medicine is MonthlyMedicine) ...[
                const Text('Mensalmente')
              ],
            ],
          ),
          if (medicine.observation?.isNotEmpty ?? false) ...[
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.comment),
                const SizedBox(width: 5),
                Expanded(child: Text(medicine.observation.toString())),
              ],
            )
          ]
        ],
      ),
    ),
  );
}
