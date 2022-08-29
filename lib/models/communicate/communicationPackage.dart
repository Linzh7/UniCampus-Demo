// import 'package:json_annotation/json_annotation.dart';
import 'package:flustars/flustars.dart';
import 'package:uni_campus/models/course.dart';

part 'communicationPackage.g.dart';

abstract class infoPackage {
  final String school;
  final String studentId;
  infoPackage(this.school, this.studentId);
}

class LoginPackage extends infoPackage {
  // final String school;
  // final String studentId;
  final String password;

  LoginPackage(String school, String studentId, this.password)
      : super(school, studentId) {}

  factory LoginPackage.fromJson(Map<String, dynamic> json) =>
      _$LoginPackageFromJson(json);
  Map<String, dynamic> toJson() => _$LoginPackageToJson(this);
}

class CoursePackage extends infoPackage {
  CoursePackage(String school, String studentId) : super(school, studentId) {}

  factory CoursePackage.fromJson(Map<String, dynamic> json) =>
      _$CoursePackageFromJson(json);
  Map<String, dynamic> toJson() => _$CoursePackageToJson(this);
}

class CourseListReceiver {
  List<Course> courseList = [];

  bool add2List(String rawData) {
    try {
      return true;
    } catch (e) {
      LogUtil.e('[CourseListReceiver] Error: $e');
      return false;
    }
  }
}
