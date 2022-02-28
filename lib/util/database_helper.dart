import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; //Singltone object
  static Database _database; //Singltone object

  String tableName = "languageTranslation";
  String langaugeCode = "langauge_code";
  String id = "id";
  String labelKey = "label_key";
  String labelValue = "label_value";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() //facttory constructor
  {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); //Named constructor
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabse();
    }
    return _database;
  }

  Future<Database> initializeDatabse() async //initialize db
  {
    var directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}language.db";
    //open/creat db in this path
    final db = await openDatabase(path, version: 1, onCreate: createDatabase);
    return db;
  }

  createDatabase(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $labelKey TEXT, $labelValue TEXT');
  }
}
