import 'package:json_annotation/json_annotation.dart';
import 'package:uni_campus/models/database/databaseHelper.dart';

part 'course.g.dart';

final String columnName = DatabaseHelper.CLASS_NAME;
final String columnLocation = DatabaseHelper.CLASS_LOCATION;
final String columnStartIndex = DatabaseHelper.CLASS_START_INDEX;
final String columnEndIndex = DatabaseHelper.CLASS_END_INDEX;
// final String columnWeek=DatabaseHelper.CLASS_WEEK;
final String columnDay = DatabaseHelper.CLASS_DAY;
final String columnTeacher = DatabaseHelper.CLASS_TEACHER;
final String columnStartWeek = DatabaseHelper.CLASS_START_WEEK;
final String columnEndWeek = DatabaseHelper.CLASS_END_WEEK;

@JsonSerializable()
class Course {
  String cname;
  String clocation;
  int cstartnumber;
  int cendnumber;
  int cday;
  String cteacher;
  int cstartweek;
  int cendweek;
  Course(this.cname, this.cday, this.cstartweek, this.cendweek,
      this.cstartnumber, this.cendnumber, this.clocation, this.cteacher);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: cname,
      columnLocation: clocation,
      columnStartIndex: cstartnumber,
      columnEndIndex: cendnumber,
      columnStartWeek: cstartweek,
      columnEndWeek: cendweek,
      columnTeacher: cteacher,
      columnDay: cday
    };
    return map;
  }

  static Course fromMap(Map<dynamic, dynamic> map) {
    return Course(
        map[columnName],
        map[columnDay],
        map[columnStartWeek],
        map[columnEndWeek],
        map[columnStartIndex],
        map[columnEndIndex],
        map[columnLocation],
        map[columnTeacher]);
  }

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
