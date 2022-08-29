import 'package:uni_campus/models/course.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coursesPackage.g.dart';

@JsonSerializable()
class CoursesPackage {
  final String studentid;
  final List<Course> coursesList;

  CoursesPackage({required this.studentid, required this.coursesList});
  factory CoursesPackage.fromJson(Map<String, dynamic> json) =>
      _$CoursesPackageFromJson(json);
  Map<String, dynamic> toJson() => _$CoursesPackageToJson(this);
}
