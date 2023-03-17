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
    periodicKind TEXT
  )
''');
  }

  static Future<Database> getDb() async {
    return openDatabase(
      'medicines.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<void> insertMedicine(Medicine medicine) async {
    final db = await getDb();
    await db.insert(
      'medicines.db',
      medicine.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
