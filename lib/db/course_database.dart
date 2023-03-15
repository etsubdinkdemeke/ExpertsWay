import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learncoding/utils/color.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import '../models/course.dart';
import '../models/lesson.dart';
import 'package:get/get.dart';
import '../models/notification.dart';

final String courseElement = 'coursesElement';
final String tablesections = 'sections';
final String lessontable = 'lessons';
final String lesson_contnent_table = 'lessonsContent';
final String progress = 'progress';
final String notification = 'notification';

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
    return await openDatabase(path, version: 2, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY';
    final idTextType = 'TEXT PRIMARY KEY';
    final textType = 'TEXT NOT NULL';
    final fk_course =
        'FOREIGN KEY (${LessonsElementFields.courseSlug}) REFERENCES $courseElement(${CourseElementFields.slug})';
    final fk_lesson =
        'FOREIGN KEY (${LessonsContentFields.lessonId}) REFERENCES $lessontable(${LessonsElementFields.lesson_id})';

    final textTypeNull = 'TEXT';
    final boolType = 'BOOLEAN NOT NULL';
    final dateType = 'DATE';
    final intType = 'INTEGER NOT NULL';
    final intTypeNull = 'INTEGER';
    print("...createing table.....");
    // CREATEING TABLES

// COURSE TABLE
    await db.execute('''
CREATE TABLE $courseElement (
      ${CourseElementFields.course_id} $idType,
      ${CourseElementFields.name} $textTypeNull,
      ${CourseElementFields.slug} $textTypeNull,
      ${CourseElementFields.description} $textTypeNull,
      ${CourseElementFields.color} $textTypeNull,
      ${CourseElementFields.icon} $textTypeNull,
      ${CourseElementFields.banner} $textTypeNull,
      ${CourseElementFields.shortVideo} $textTypeNull,
      ${CourseElementFields.lastUpdated} $textTypeNull,
      ${CourseElementFields.eneabled} $boolType,
      ${CourseElementFields.seenCounter} $intTypeNull,
      ${CourseElementFields.isLastSeen} $intTypeNull
       )
    ''');

// LESSON TABLE
    await db.execute('''
CREATE TABLE $lessontable (
      ${LessonsElementFields.lesson_id} $intType,
      ${LessonsElementFields.slug} $textType,
      ${LessonsElementFields.title} $textType,
      ${LessonsElementFields.shortDescription} $textType,
      ${LessonsElementFields.section} $textType,
      ${LessonsElementFields.courseSlug} $textType,
      ${LessonsElementFields.publishedDate} $textType,
      $fk_course
    )
    ''');

// LESSON CONTENT TABLE
    await db.execute('''
CREATE TABLE $lesson_contnent_table (
      ${LessonsContentFields.id} $idType,
      ${LessonsContentFields.lessonId} $textTypeNull,
      ${LessonsContentFields.content} $textTypeNull,
      $fk_lesson
    )
    ''');

// PROGRESS TABLE
    await db.execute('''
CREATE TABLE $progress (
      ${ProgressFields.progId} $idType,
      ${ProgressFields.courseId} $textTypeNull,
      ${ProgressFields.lessonId} $textTypeNull,
      ${ProgressFields.contentId} $textTypeNull,
      ${ProgressFields.pageNum} $intTypeNull,
      ${ProgressFields.userProgress} $textTypeNull
    )
    ''');

// NOTIFICATION TABLE
    await db.execute('''
CREATE TABLE $notification (
      ${NotificationFields.id} $idType,
      ${NotificationFields.heighlightText} $textTypeNull,
      ${NotificationFields.type} $textTypeNull,
      ${NotificationFields.imgUrl} $textTypeNull,
      ${NotificationFields.createdDate} $textTypeNull
    )
    ''');
  }

  Future<CourseElement> createCourses(CourseElement courseElem) async {
    final db = await instance.database;

    final id = await db.insert(courseElement, courseElem.toJson());
    //for (var i = 0; i < courseElem.sections!.length; i++) {
    //   await CourseDatabase.instance
    //       .createSection(courseElem.sections![i], id.toString());
    //}

    return courseElem.copy(course_id: id);
  }

  Future<void> createLessons(LessonElement lessonElement) async {
    final db = await instance.database;
    try {
      final json = lessonElement.toJson();
      final columns =
          '${LessonsElementFields.lesson_id},${LessonsElementFields.slug},${LessonsElementFields.title},${LessonsElementFields.shortDescription},${LessonsElementFields.section},${LessonsElementFields.courseSlug},${LessonsElementFields.publishedDate}';

      await db.rawInsert(
        'INSERT INTO $lessontable ($columns) VALUES (?,?,?,?,?,?,?)',
        [
          json[LessonsElementFields.lesson_id].toString(),
          json[LessonsElementFields.slug],
          json[LessonsElementFields.title],
          json[LessonsElementFields.shortDescription],
          json[LessonsElementFields.section],
          json[LessonsElementFields.courseSlug],
          json[LessonsElementFields.publishedDate],
        ],
      );

      for (var i = 0; i < lessonElement.content.length; i++) {
        CourseDatabase.instance.createLessonsContent(lessonElement.content[i],
            json[LessonsElementFields.lesson_id].toString());
      }
    } on DatabaseException catch (error) {
      Get.snackbar("", "",
          borderWidth: 2,
          borderColor: maincolor,
          dismissDirection: DismissDirection.horizontal,
          duration: Duration(seconds: 4),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.885),
          titleText: Text(
            'Error',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            '$error',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          margin: EdgeInsets.only(top: 12));
    } catch (e) {
      Get.snackbar("", "",
          borderWidth: 2,
          borderColor: maincolor,
          dismissDirection: DismissDirection.horizontal,
          duration: Duration(seconds: 4),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.885),
          titleText: Text(
            'Error',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            '${e}',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          margin: EdgeInsets.only(top: 12));
    }
  }

  Future<void> createLessonsContent(String content, String lessonid) async {
    final db = await instance.database;
    LessonContent lescon = LessonContent(lessonId: lessonid, content: content);
    final id = await db.insert(lesson_contnent_table, lescon.toJson());
    lescon.copy(id: id);
  }

  Future<ProgressElement> createProgress(
      ProgressElement progressElement) async {
    final db = await instance.database;
    final json = progressElement.tojson();
    final columns =
        '${ProgressFields.progId},${ProgressFields.courseId},${ProgressFields.lessonId},${ProgressFields.contentId},${ProgressFields.pageNum},${ProgressFields.userProgress}';

    // final id = await db.insert(progress, progressElement.tojson());
    int id = await db.rawInsert(
      'INSERT INTO $progress ($columns) VALUES (?,?,?,?,?,?)',
      [
        json[ProgressFields.progId],
        json[ProgressFields.courseId],
        json[ProgressFields.lessonId],
        json[ProgressFields.contentId],
        json[ProgressFields.pageNum],
        json[ProgressFields.userProgress],
      ],
    );
    return progressElement.copy(progId: id);
  }

  Future<void> createNotification(
      NotificationElement notificationElement) async {
    final db = await instance.database;
    try {
      final id = await db.insert(notification, notificationElement.tojson());

      notificationElement.copy(id: id);
    } on DatabaseException catch (error) {
      Get.snackbar("", "",
          borderWidth: 2,
          borderColor: maincolor,
          dismissDirection: DismissDirection.horizontal,
          duration: Duration(seconds: 4),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.885),
          titleText: Text(
            'Error',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            '$error',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          margin: EdgeInsets.only(top: 12));
    } catch (e) {
      Get.snackbar("", "",
          borderWidth: 2,
          borderColor: maincolor,
          dismissDirection: DismissDirection.horizontal,
          duration: Duration(seconds: 4),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.885),
          titleText: Text(
            'Error',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            '${e}',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          margin: EdgeInsets.only(top: 12));
    }
  }

// READ COURSE DATA'
  Future<Course> readCourse(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      courseElement,
      columns: CourseElementFields.values,
      where: '${CourseElementFields.course_id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Course.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<CourseElement> readCourseNameandIcon(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      courseElement,
      columns: CourseElementFields.values,
      where: '${CourseElementFields.course_id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return CourseElement.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<LessonElement>> readLesson(String courseSlug) async {
    final db = await instance.database;
    try {
      final result = await db.query(
        lessontable,
        columns: LessonsElementFields.values,
        where: '${LessonsElementFields.courseSlug} = ?',
        whereArgs: [courseSlug],
      );
      return result.map((json) => LessonElement.fromJson(json)).toList();
    } on DatabaseException catch (error) {
      Get.snackbar("", "",
          borderWidth: 2,
          borderColor: maincolor,
          dismissDirection: DismissDirection.horizontal,
          duration: Duration(seconds: 4),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.885),
          titleText: Text(
            'Error',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            'Unable to read data from database',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          margin: EdgeInsets.only(top: 12));
      return [];
    } catch (e) {
      Get.snackbar("", "",
          borderWidth: 2,
          borderColor: maincolor,
          dismissDirection: DismissDirection.horizontal,
          duration: Duration(seconds: 4),
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.885),
          titleText: Text(
            'Error',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          messageText: Text(
            '${e}',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
          ),
          margin: EdgeInsets.only(top: 12));
      return [];
    }

    // return [];
  }

  Future<List<CourseElement>> readAllCourse() async {
    final db = await instance.database;
    final orderby = '${CourseElementFields.isLastSeen} ASC';
    final result = await db.query(courseElement, orderBy: orderby);
    return result.map((json) => CourseElement.fromJson(json)).toList();
  }

  Future<List<LessonContent>> readLessonContets(int lessonId) async {
    final db = await instance.database;
    final result = await db.query(
      lesson_contnent_table,
      columns: LessonsContentFields.lessonsvalue,
      where: '${LessonsContentFields.lessonId} = ?',
      whereArgs: [lessonId],
    );
    if (result.isNotEmpty) {
      return result.map((json) => LessonContent.fromJson(json)).toList();
    }
    if (result.isEmpty) {
      return [];
    } else {
      return [];
    }
  }

  Future<List<LessonContent>> readAllLessonContent() async {
    final db = await instance.database;

    final result = await db.query(lesson_contnent_table);

    return result.map((json) => LessonContent.fromJson(json)).toList();
  }

  Future<ProgressElement?> readProgress(String course, String id) async {
    final db = await instance.database;
    final maps = await db.query(
      progress,
      columns: ProgressFields.progressvalue,
      where:
          '${ProgressFields.courseId} = ? and ${ProgressFields.lessonId} = ? ',
      whereArgs: [course, id],
    );
    if (maps.isNotEmpty) {
      return ProgressElement.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Future<List<NotificationElement>> readAllNotification() async {
    final db = await instance.database;

    final result = await db.query(notification);

    return result.map((json) => NotificationElement.fromJson(json)).toList();
  }

// UPDATE DATA'
  Future updateProgress(ProgressElement progressElement) async {
    final db = await instance.database;
    await db.update(
      progress,
      progressElement.tojson(),
      where: '${ProgressFields.courseId}= ? and ${ProgressFields.lessonId}= ?',
      whereArgs: [
        progressElement.courseId,
        progressElement.lessonId,
      ],
    );
  }

// DELETE DATA
  Future<int> deleteNotification(int id) async {
    final db = await instance.database;

    return await db.delete(
      notification,
      where: '${NotificationFields.id}=?',
      whereArgs: [id],
    );
  }

// close DATABASE
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

// SECTION TABLE
//     await db.execute('''
// CREATE TABLE $tablesections (
//       ${SectionFields.sec_id} $idType,
//       ${SectionFields.course_id} $textTypeNull,
//       ${SectionFields.sections} $textTypeNull,
//       ${SectionFields.level} $textTypeNull,

//     )
//     ''');

// Future<Section> createSection(Section courseSec, String courseid) async {
//   final db = await instance.database;
//   final json = courseSec.toJson();
//   final columns =
//       '${SectionFields.sec_id},${SectionFields.course_id},${SectionFields.sections},${SectionFields.level}';
//   final values =
//       '${json[SectionFields.sec_id]},$courseid,${SectionFields.sections},${json[SectionFields.level]}';
//   final id = await db.rawInsert(
//       'INSERT INTO $tablesections ($columns) VALUES(?,?,?,?)', [values]);
//   return courseSec.copy(sec_id: id.toString());
// }

/********* */

// Future<List<Section>> readAllSection() async {
//     final db = await instance.database;
//     final result = await db.query(tablesections);
//     return result.map((json) => Section.fromJson(json)).toList();
//   }

// Future<List<LessonElement>> readAllLesson() async {
//   final db = await instance.database;

//   final result = await db.query(lessontable);
//   if (result.isNotEmpty) {
//     return result.map((json) => LessonElement.fromJson(json)).toList();
//   } else
//     return [];
// }
