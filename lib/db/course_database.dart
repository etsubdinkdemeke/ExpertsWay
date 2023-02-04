import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/course_table.dart';
class CourseDatabase {
  static final CourseDatabase instance = CourseDatabase.init();

  static Database? _database;

  CourseDatabase.init();


    Future<Database> get database async {
    // if it's exist return database
    if (_database != null) return _database!;

    // other wise inisialize a database
    _database = await _initDB('course.db');
    return _database!;
  }

    Future<Database> _initDB(String filePath) async {
    // get the default database location
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

    Future _createDB(Database db, int version) async {
    final idType = ' INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    // final boolType = 'BOOLEAN NOT NULL';
    final intType = 'INTEGER NOT NULL';
    print("...createing table.....");
    await db.execute('''
CREATE TABLE $tableCourse (
      ${CourseFields.id} $idType,
      ${CourseFields.name} $textType,
      ${CourseFields.description} $textType,
      ${CourseFields.iconName} $textType,
      ${CourseFields.video} $textType,
      ${CourseFields.seenCounter} $intType,
      ${CourseFields.isLastSeen} $textType
    )
    ''');
  }

    Future<CourseTable> create(CourseTable note) async {
    final db = await instance.database;

    final id = await db.insert(tableCourse, note.toJson());
    return note.copy(id: id);
  }

    Future<CourseTable> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableCourse,
      columns: CourseFields.values,
      where: '${CourseFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CourseTable.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }




  Future close() async {
    final db = await instance.database;
    db.close();
  }

}
