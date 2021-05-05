import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper  {

  static DbHelper? _instance;
  static DbHelper get instance {
    _instance ??= DbHelper._init();
    return _instance!;
  }

  DbHelper._init();

  Database? _db;
  bool isInitialized = false;

  Future<Database?> getDb() async {
    if (!isInitialized) await init();
    return _db;
  }

  Future<void> init() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'notes.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: onCreateDb,
      onUpgrade: onUpgradeDb,
    );
  }

  Future<void> onCreateDb(Database db, int version) async {
    await db.execute('''CREATE TABLE Notes 
      (id INTEGER PRIMARY KEY,title TEXT, createdAt TEXT, icon TEXT, color TEXT, content TEXT )''');
  }

  Future<void> onUpgradeDb(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS "Notes"');
    await onCreateDb(db, newVersion);
  }
}