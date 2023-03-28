import 'package:app_medicine_scheduler/models/medicine.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<void> createTables(Database db) async {
    return await db.execute('''
  CREATE TABLE medicines (
    id TEXT PRIMARY KEY,
    name TEXT,
    initialDate TEXT,
    active INTEGER,
    observation TEXT,
    periodicKind TEXT,
    period INTEGER,
    offset TEXT
  )
''');
  }

  static Future<Database> getDb() async {
    return openDatabase(
      'medicines',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<void> insertMedicine(Medicine medicine) async {
    final db = await getDb();
    await db.insert(
      'medicines',
      medicine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Medicine>> getMedicinesFromTable() async {
    var table = await queryAllRows();
    List<Medicine> ret = [];
    table.forEach((element) {
      if (element['periodicKind'] == 'Diariamente') {
        ret.add(DailyMedicine.fromMap(element));
      } else if (element['periodicKind'] == 'Semanalmente') {
        ret.add(WeeklyMedicine.fromMap(element));
      } else if (element['periodicKind'] == 'Mensalmente') {
        ret.add(MonthlyMedicine.fromMap(element));
      } else if (element['periodicKind'] == 'Personalizado') {
        ret.add(PeriodicMedicine.fromMap(element));
      } else if (element['periodicKind'] == 'Especifico') {
        ret.add(SpecificHoursMedicine.fromMap(element));
      }
    });
    return ret;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await getDb();
    var a = await db.query('medicines');
    print(a);
    return a;
  }
}
