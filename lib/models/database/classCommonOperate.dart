import 'package:flustars/flustars.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uni_campus/models/course.dart';
import 'package:uni_campus/models/database/databaseHelper.dart';

class ClassCommonOperate {
  Database? db;
  DatabaseHelper dbHelper = new DatabaseHelper();

  Future open() async {
    db = await dbHelper.open();
  }

  Future close() async {
    if (db != null && db!.isOpen) {
      db!.close();
    }
  }

  Future<bool> removeAll() async {
    if (db == null) {
      await open();
    }
    try {
      await db!.delete(DatabaseHelper.CLASS_TABLE_NAME);
      LogUtil.v("[DB] all deleted.");
      return true;
    } catch (e) {
      LogUtil.e("[DB] ERROR, $e.");
      return false;
    }
  }

  Future<bool> deleteCourse(
      String name, int day, int startIndex, int endIndex) async {
    if (db == null) {
      await open();
    }
    try {
      db!.delete(DatabaseHelper.CLASS_TABLE_NAME,
          where:
              "${DatabaseHelper.CLASS_NAME}=? and ${DatabaseHelper.CLASS_DAY}=? and ${DatabaseHelper.CLASS_START_INDEX}>=? and ${DatabaseHelper.CLASS_END_INDEX}<=?",
          whereArgs: [name, day, startIndex, endIndex]);
      LogUtil.v("[DB] delete $name done.");
      return true;
    } catch (e) {
      LogUtil.v("[DB] DELETE ERROR, $e.");
      return false;
    }
  }

  Future<List<bool>> selectCourseWeek(
      String name, int day, int startIndex, int endIndex) async {
    if (db == null) {
      await open();
    }
    List<bool> ls = [];
    for (int i = 0; i < 19; i++) {
      ls.add(false);
    }
    try {
      List<Map<String, Object?>> result = await db!.query(
          DatabaseHelper.CLASS_TABLE_NAME,
          where:
              "${DatabaseHelper.CLASS_NAME}=? and ${DatabaseHelper.CLASS_DAY}=? and ${DatabaseHelper.CLASS_START_INDEX}>=? and ${DatabaseHelper.CLASS_END_INDEX}<=?",
          whereArgs: [name, day, startIndex, endIndex]);
      // LogUtil.v("[DB] select $name done. $result");
      for (var ele in result) {
        for (int i = int.parse(ele[DatabaseHelper.CLASS_START_WEEK].toString());
            i < int.parse(ele[DatabaseHelper.CLASS_END_WEEK].toString()) + 1;
            i++) {
          ls[i] = true;
          // LogUtil.v("[debug] $i: true.");
        }
      }
      // LogUtil.v("[DB] ${ls.toString()}");
      return ls;
    } catch (e) {
      LogUtil.v("[DB] select ERROR, $e.");
      return ls;
    }
  }

  Future<bool> checkCourseValid(String className, int day, int startWeek,
      int endWeek, int startIndex, int endIndex) async {
    if (db == null) {
      await open();
    }
    try {
      List<Map> result = await db!.query(DatabaseHelper.CLASS_TABLE_NAME,
          where:
              '(${DatabaseHelper.CLASS_NAME}!=? and ${DatabaseHelper.CLASS_DAY}=? and ${DatabaseHelper.CLASS_START_WEEK}<=? and ${DatabaseHelper.CLASS_END_WEEK}>=? and ${DatabaseHelper.CLASS_START_INDEX}<=? and ${DatabaseHelper.CLASS_END_INDEX}>=?)',
          whereArgs: [
            className,
            day,
            endWeek,
            startWeek,
            endIndex,
            startIndex
          ]);
      LogUtil.v("[DB] result: $result");
      if (result.length == 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      LogUtil.v("[DB] CHECK ERROR, $e.");
      return false;
    }
  }

  Future<bool> updateCourse(Course oldCourse, Course newCourse) async {
    if (db == null) {
      await open();
    }
    try {
      db!.delete(
        DatabaseHelper.CLASS_TABLE_NAME,
        where:
            "${DatabaseHelper.CLASS_NAME}=? and ${DatabaseHelper.CLASS_DAY}=? and ${DatabaseHelper.CLASS_START_WEEK}=? and ${DatabaseHelper.CLASS_END_WEEK}=? and ${DatabaseHelper.CLASS_START_INDEX}>=? and ${DatabaseHelper.CLASS_END_INDEX}<=?",
        whereArgs: [
          oldCourse.cname,
          oldCourse.cday,
          oldCourse.cstartweek,
          oldCourse.cendweek,
          oldCourse.cstartnumber,
          oldCourse.cendnumber
        ],
      );
      LogUtil.v("[DB] update-delete done.");
      db!.insert(DatabaseHelper.CLASS_TABLE_NAME, newCourse.toMap());
      LogUtil.v("[DB] update-insert done.");
      return true;
    } catch (e) {
      LogUtil.v("[DB] UPDATE ERROR, $e.");
      return false;
    }
  }

  Future<bool> insertCourses(List<Course> coursesList) async {
    if (db == null) {
      await open();
    }
    try {
      await open();
      LogUtil.v("[DB] Start adding courses...");
      for (int i = 0; i < coursesList.length; i++) {
        try {
          // LogUtil.v(coursesList[i].toMap());
          db!.insert(DatabaseHelper.CLASS_TABLE_NAME, coursesList[i].toMap());
          // LogUtil.v("[DB] add ${coursesList[i].toMap()}.");
        } catch (e) {
          LogUtil.v("[DB] Insert error on ${coursesList[i].toMap()} , $e.");
        }
      }
      LogUtil.v("[DB] Done.");
      return true;
    } catch (e) {
      LogUtil.v("[DB] INSERT ERROR, $e.");
      return false;
    }
  }
}
