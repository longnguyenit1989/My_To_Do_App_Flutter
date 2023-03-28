import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static const _databaseName = "quotes_database.db";
  static const _databaseVersion = 1;

  static const tableQuote = 'quotes';

  static const columnId = '_id';
  static const columnContent = 'content';
  static const columnAuthor = 'author';

  static final DbProvider dbProvider = DbProvider();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await init();
    return _db!;
  }

  init() async {
    final dbDir = await getDatabasesPath();
    final path = join(dbDir, _databaseName);
    var db = await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
    return db;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableQuote($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnContent TEXT, $columnAuthor TEXT)");
  }
}
