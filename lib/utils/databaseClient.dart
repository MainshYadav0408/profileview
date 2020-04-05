import 'dart:async';
import 'dart:io';
import '../models/users.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  final String tableName = 'Users';
  final String columnId = 'userName';
  final String columnPassword = 'password';
  final String columnFirstName = 'fName';
  final String columnLastName = 'lName';
  final String columnDob = 'dob';
  final String columnGender = 'gender';
  final String columnPhone = 'phone';
  final String columnEmail = 'email';

  static Database _db;
  Future<Database> get db async {
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "user_db.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int version) async{
    await db.execute(
      "CREATE TABLE $tableName($columnId INTGER PRIMARY KEY, $columnPassword VARCHAR(20), $columnFirstName TEXT, $columnLastName TEXT, $columnDob VARCHAR(30),$columnGender TEXT, $columnEmail VARCHAR(30), $columnPhone INTEGER)"
    );
    print("Table is created");
  }
  Future<int> saveUser(User user) async {
    var dbClient = await db;
    int res = await dbClient.insert('$tableName', user.tomap());
    print(res.toString());
    return res;
  }

  Future<List> getUser() async{
    var dbClient =  await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnFirstName ASC");
    return result.toList();
  }

  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }
}

