import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = "my_todo_table";

  static const columnId = "_id";
  static const columnName = "name";
  static const columnChecked = "checked";

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnChecked INTEGER
        )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $table');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[columnId];
    return await _db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateFollowName(String oldName, String newName) async {
    final values = {columnName: newName};
    const where = "$columnName = ?";
    final whereArgs = [oldName];
    return await _db.update(table, values, where: where, whereArgs: whereArgs);
  }

  Future<int> delete(String name) async {
    return await _db.delete(table, where: "$columnName = ?", whereArgs: [name]);
  }
}