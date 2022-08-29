import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  final String sname;
  final String smajor;
  final String sdepartment;
  final String sclass;
  final String ssgrade;

  Student(this.sname, this.smajor, this.sdepartment, this.sclass, this.ssgrade);

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
