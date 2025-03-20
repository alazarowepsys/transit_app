import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:transit_app/models/fine.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService();
  Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    await _initDatabase();

    return _database!;
  }

  _initDatabase() async {
    String databasePath = join(await getDatabasesPath(), 'transit_app.db');
    _database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE fines (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tag_code TEXT NOT NULL,
            brand TEXT NOT NULL,
            model TEXT NOT NULL,
            color TEXT NOT NULL,
            year INTEGER NOT NULL,
            license_plate TEXT NOT NULL,
            violation_type TEXT NOT NULL,
            latitude REAL,
            longitude REAL,
            timestamp INTEGER NOT NULL,
            description TEXT NOT NULL,
            image_path TEXT NOT NULL,
            audio_record_path TEXT NOT NULL
          );
        ''');
      },
    );
  }

  Future<int> insertFine(Fine newFine) async {
    Database db = await database;
    return db.insert('fines', newFine.toMap());
  }

  Future<List<Fine>> getFines() async {
    Database db = await database;
    List<Map<String, dynamic>> fines = await db.query('fines');
    return fines.map((e) => Fine.fromMap(e)).toList();
  }

  Future<void> deleteAllFines() async {
    Database db = await database;
    await db.delete('fines');
  }
}
