import 'package:flustars/flustars.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final int DATABASE_VERSION = 1;
  static final String DATABASE_NAME = "courses.db";
  static final String CLASS_TABLE_NAME = "courses";
  static final String TEXT_TYPE = " TEXT";
  static final String INTEGER_TYPE = " INTEGER";
  static final String COMMA = ",";
  static final String CLASS_NAME = "cname";
  static final String CLASS_LOCATION = "clocation";
  static final String CLASS_START_INDEX = "cstartnumber";
  static final String CLASS_END_INDEX = "cendnumber";
  static final String CLASS_DAY = "cday";
  static final String CLASS_START_WEEK = "cstartweek";
  static final String CLASS_END_WEEK = "cendweek";
  static final String CLASS_TEACHER = "cteacher";
  static final String SQL_CREATE_CLASS = "CREATE TABLE " +
      CLASS_TABLE_NAME +
      " (" +
      CLASS_NAME +
      TEXT_TYPE +
      COMMA +
      CLASS_LOCATION +
      TEXT_TYPE +
      COMMA +
      CLASS_START_INDEX +
      INTEGER_TYPE +
      COMMA +
      CLASS_END_INDEX +
      INTEGER_TYPE +
      COMMA +
      CLASS_START_WEEK +
      INTEGER_TYPE +
      COMMA +
      CLASS_END_WEEK +
      INTEGER_TYPE +
      COMMA +
      // CLASS_WEEK + INTEGER_TYPE + COMMA +
      CLASS_DAY +
      INTEGER_TYPE +
      COMMA +
      CLASS_TEACHER +
      TEXT_TYPE +
      COMMA +
      "PRIMARY KEY (" +
      CLASS_NAME +
      COMMA +
      CLASS_START_WEEK +
      COMMA +
      CLASS_START_INDEX +
      COMMA +
      CLASS_DAY +
      ")" +
      ");";

  Future<Database> open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DATABASE_NAME);
    Database db = await openDatabase(path, version: DATABASE_VERSION,
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
      try {
        await db.query(CLASS_TABLE_NAME);
      } catch (e) {
        await db.execute(SQL_CREATE_CLASS);
      }
      LogUtil.v('[Database] From Upgrade');
    }, onCreate: (Database db, int version) async {
      await db.execute(SQL_CREATE_CLASS);
      LogUtil.v('[Database] From OnCreate');
    });
    return db;
  }
}
