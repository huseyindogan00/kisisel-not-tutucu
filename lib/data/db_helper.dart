// ignore_for_file: unnecessary_null_comparison
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_do_app/model/job.dart';
import 'package:to_do_app/model/table_enum.dart';
import 'package:to_do_app/model/user.dart';

class DbHelper {
  final Map<String, String> _dbInfo = {'dbName': 'works2.db'};
  Database? _database;
  //DbHelper? _dbHelper;

  DbHelper() {
    _initializeDatabase();
  }

  Future<Database?> get db async {
    // ignore: prefer_conditional_assignment
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    }
    return _database;
  }

  // DATABASE OLUŞTURULUYOR
  Future<Database?> _initializeDatabase() async {
    String filePath = await getDatabasesPath();
    String dbPath = join(filePath, _dbInfo['dbName']);
    var dbWork = await openDatabase(dbPath, version: 2, onCreate: _createTable);
    return dbWork;
  }

  // TABLO OLUŞTURULUYOR
  void _createTable(Database eWorkDb, int version) async {
    await eWorkDb.execute('''CREATE TABLE job (
      id INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
      caption TEXT,
      content TEXT,
      creationDate TEXT,
      jobState INTEGER
      ) 
      ''');
    await eWorkDb.execute('''CREATE TABLE user (
      id INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
      userName TEXT,
      password TEXT
    )
    ''');
  }

  Future<List<Job>> getJobList() async {
    Database? db = await this.db;
    List<Map<String, dynamic>> result = await db!.query(TableEnum.job.name);
    List<Job> jobs = result.map((job) => Job.fromObject(job)).toList();
    return jobs;
  }

  Future<int> addJob(Job job) async {
    Database? db = await this.db;
    int result = await db!.insert(TableEnum.job.name, job.toMap());
    return result;
  }

  Future<int> updateJob(Job job) async {
    Database? db = await this.db;
    print(job.id);
    print(job.caption);
    print(job.content);
    print(job.creationDate);
    print(job.toMap());
    int result = await db!
        .update('job', job.toMap(), where: 'id=?', whereArgs: [job.id]);
    return result;
  }

  Future<int> updateJobState(int id, int jobState) async {
    Database? db = await this.db;
    var stateMap = {'jobState': jobState};
    int result =
        await db!.update('job', stateMap, where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<int> delete(int id, String? tableName) async {
    Database? db = await this.db;
    var result = await db!.delete('$tableName', where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<int> addUser(User user) async {
    Database? db = await this.db;
    int result = await db!.insert(TableEnum.job.name, user.toMap(user));
    return result;
  }

  Future<List<User>> getUsers() async {
    Database? db = await this.db;
    List<Map<String, dynamic>> result = await db!.query(TableEnum.user.name);
    List<User> user = result.map((user) => User.fromMap(user)).toList();
    return user;
  }

  Future<bool> login(String userName, String password) async {
    Database? db = await this.db;
    List<String> arguments = [userName.trim(), password.trim()];
    List<Map<String, dynamic>> result = await db!.rawQuery(
        'SELECT * FROM user WHERE userName=? and password=?', arguments);
    return result.isNotEmpty ? true : false;
  }
}
