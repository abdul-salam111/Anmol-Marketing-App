import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class AnmolMarketingDatabase {
  static Database? _db;

  Future<Database?> get database async {
    if (_db != null) return _db;
    _db = await initializeDatabase();
    return _db;
  }

  Future<Database> initializeDatabase() async {
    try {
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, "anmol_marketing_database.db");
      var db = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
      );
      return db;
    } catch (e) {
      print("Database Error: $e");
      rethrow; // Important to rethrow the error
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE companies(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        companyId TEXT NOT NULL,
        companyName TEXT NOT NULL,
        companyLogo TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE catalog(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        companyId TEXT NOT NULL,
        companyName TEXT NOT NULL,
        companyLogo TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Example migration:
      // await db.execute('ALTER TABLE companies ADD COLUMN new_column TEXT');
      print("Database upgraded from $oldVersion to $newVersion");
    }
  }
}
