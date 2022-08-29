import 'package:flustars/flustars.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uni_campus/models/course.dart';
import 'package:uni_campus/models/database/databaseHelper.dart';

class ClassListGetter {
  Database? db;
  DatabaseHelper dbHelper = new DatabaseHelper();

  // database
  Future open() async {
    db = await dbHelper.open();
  }

  Future close() async {
    if (db != null && db!.isOpen) {
      db!.close();
    }
  }

  Future<List<Course>> getHalfDayClasses(
      int day, int week, int startIndex, int endIndex) async {
    if (db != null && !db!.isOpen) {
      await open();
    }
    List<Map> result = await db!.query(DatabaseHelper.CLASS_TABLE_NAME,
        where:
            "${DatabaseHelper.CLASS_DAY}=? and ${DatabaseHelper.CLASS_START_WEEK}<=? and ${DatabaseHelper.CLASS_END_WEEK}>=? and ${DatabaseHelper.CLASS_START_INDEX}>=? and ${DatabaseHelper.CLASS_END_INDEX}<=?",
        whereArgs: [day, week, week, startIndex, endIndex],
        orderBy: "${DatabaseHelper.CLASS_START_INDEX}");
    // LogUtil.v("[DEBUG] got ${week}w ${day}d, ${startIndex}-${endIndex} info.");
    List<Course> classList = [];
    for (var element in result) {
      classList.add(Course.fromMap(element));
      // LogUtil.v(Course.fromMap(element).toJson());
    }
    // LogUtil.v("[DEBUG] got ${week}w ${day}d, ${startIndex}-${endIndex} info, result: $result.");
    return classList;
  }

  Future<List<Course>> getAllClasses() async {
    await open();
    List<Map> result = await db!.query(DatabaseHelper.CLASS_TABLE_NAME);
    LogUtil.v("[DB] got all info.");
    List<Course> classList = [];
    for (var element in result) {
      classList.add(Course.fromMap(element));
      // LogUtil.v("[DB] ${Course.fromMap(element).toJson()}");
    }
    return classList;
  }

  Future<bool> removeAll() async {
    try {
      await open();
      await db!.delete(DatabaseHelper.CLASS_TABLE_NAME);
      LogUtil.v("[DB] all deleted.");
      return true;
    } catch (e) {
      LogUtil.e("[DB] ERROR, $e.");
      return false;
    }
  }
}
