import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  
  static const _databaseName = "Questions.db";
  static const _databaseVersion = 1;

  //variables for question table
  static const table = 'all_quests';
  static const columnId = '_id';
  static const columnName = 'question';
  static const correctAns = "correct_answer";
  static const marks = 'marks';

  //variables for selected answers table
  static const table2 = 'given_answers';
  static const columnId2 = '_id';
  static const columnName2 = 'question';
  static const givenAnswer = 'answer';
  static const correctAnswer = 'correct_answer';
  static const date = 'date';


  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  //for question db
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabaseToInsert();
    return _database;
  }


  // this opens the database (and creates it if it doesn't exist)
  _initDatabaseToInsert() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreateTable);
  }


  // SQL code to create the database table for question insertion
  Future _onCreateTable(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $correctAns TEXT NOT NULL,
            $marks INTEGER NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $table2 (
            $columnId2 INTEGER PRIMARY KEY,
            $columnName2 TEXT NOT NULL,
            $correctAnswer TEXT NOT NULL,
            $givenAnswer TEXT NOT NULL,
            $date TEXT NOT NULL
          )
          ''');
  }


  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insertQuest(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<int> insertAns(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table2, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllQuestRows() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<List<Map<String, dynamic>>> queryAllAnsRows() async {
    Database? db = await instance.database;
    return await db!.query(table2);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryQuestRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }
  Future<int?> queryQuestAnsRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $table2'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int?> updateQuest(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<int?> updateAns(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId2];
    return await db!.update(table2, row, where: '$columnId2 = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> deleteQuest(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
  Future<int> deleteAns(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table2, where: '$columnId2 = ?', whereArgs: [id]);
  }
}