import 'package:resume_builder_app/model/datamodel.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ResumeDatabaseHelper {
  static final _resumeDatabaseName = "resumedb.db";
  static final _databaseVersion = 4;

  static final resumeTable = 'resume_table';

  static final columnId = 'id';
  static final fname = 'fname';
  static final lname = 'lname';
  static final age = 'age';
  static final mobile = 'mobile';
  static final totalYearsOfExperience = 'totalYearsOfExperience';
  static final pasportNo = 'pasportNo';
  static final maritalStatus = 'maritalStatus';
  static final profile = 'profile';
  static final address = 'address';
  static final email = 'email';
  static final aboutMe = 'aboutMe';

  static final companyName = 'companyName';
  static final fromDate = 'fromDate';
  static final toDate = 'toDate';

  static final projectName = 'projectName';
  static final projectDetails = 'projectDetails';
  // make this a singleton class
  ResumeDatabaseHelper._privateConstructor();
  static final ResumeDatabaseHelper instance =
      ResumeDatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _resumeDatabaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $resumeTable (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $fname TEXT NOT NULL,
            $lname TEXT NOT NULL,
            $mobile TEXT NOT NULL,
            $age INTEGER NOT NULL,
            $totalYearsOfExperience TEXT NOT NULL,
            $pasportNo TEXT NOT NULL,
            $maritalStatus TEXT NOT NULL,
            $profile TEXT NOT NULL,
            $address TEXT NOT NULL,
            $email TEXT NOT NULL,
            $aboutMe TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(ResumeModel model) async {
    Database db = await instance.database;
    return await db.insert(resumeTable, {
      fname: model.fname,
      lname: model.lname,
      mobile: model.mobile,
      age: model.age,
      totalYearsOfExperience: model.totalYearsOfExperience,
      pasportNo: model.pasportNo,
      maritalStatus: model.maritalStatus,
      profile: model.profile,
      address: model.address,
      email: model.email,
      aboutMe: model.aboutMe
    });
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(resumeTable);
  }

  // Queries rows based on the argument received
  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database db = await instance.database;
    return await db.query(resumeTable, where: "$fname LIKE '%$name%'");
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $resumeTable'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(ResumeModel model) async {
    Database db = await instance.database;
    int id = model.toMap()['id'];
    return await db.update(resumeTable, model.toMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(resumeTable, where: '$columnId = ?', whereArgs: [id]);
  }
}
