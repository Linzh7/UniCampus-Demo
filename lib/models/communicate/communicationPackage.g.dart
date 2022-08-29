// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communicationPackage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPackage _$LoginPackageFromJson(Map<String, dynamic> json) => LoginPackage(
      json['school'] as String,
      json['studentId'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$LoginPackageToJson(LoginPackage instance) =>
    <String, dynamic>{
      '"school"': '"' + instance.school + '"',
      '"studentId"': '"' + instance.studentId + '"',
      '"password"': '"' + instance.password + '"',
    };

CoursePackage _$CoursePackageFromJson(Map<String, dynamic> json) =>
    CoursePackage(
      json['school'] as String,
      json['studentid'] as String,
    );

Map<String, dynamic> _$CoursePackageToJson(CoursePackage instance) =>
    <String, dynamic>{
      '"school"': '"' + instance.school + '"',
      '"studentid"': '"' + instance.studentId + '"',
    };
