import 'db_helper.dart';
import '../models/note.dart';

class Dao implements IDao {
  static Dao? _instance;

  static Dao instance(DbHelper dbHelper) {
    _instance ??= Dao._init(dbHelper);
    return _instance!;
  }

  final DbHelper _dbHelper;
  Dao._init(this._dbHelper);

  @override
  Future<List<Note>> getAll() async {
    final db = await _dbHelper.getDb();
    var result = await db?.query('Notes');
    return result?.map((e) => Note.fromMap(e)).toList() ?? [];
  }

  @override
  Future<int> create(Note note) async {
    final db = await _dbHelper.getDb();
    return await db?.insert('Notes', note.toMap()) ?? -1;
  }

  @override
  Future<int> saveNote(Note note) async {
    final db = await _dbHelper.getDb();
    var result = await db?.update('Notes', note.toMap(),
        whereArgs: [note.id], where: 'id = ?');
    return result ?? -1;
  }

  @override
  Future<int> delete(Note note) async {
    final db = await _dbHelper.getDb();
    var result = await db?.delete('Notes', whereArgs: [note.id], where: 'id = ?');
    return result ?? -1;
  }
}

abstract class IDao {
  Future<List<Note>> getAll();
  Future<int> create(Note note);
  Future<int> delete(Note note);
  Future<int> saveNote(Note note);
}
