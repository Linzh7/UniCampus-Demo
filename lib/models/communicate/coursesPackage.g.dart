// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coursesPackage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursesPackage _$CoursesPackageFromJson(Map<String, dynamic> json) =>
    CoursesPackage(
      studentid: json['studentid'] as String,
      coursesList: (json['coursesList'] as List<dynamic>)
          .map((e) => Course.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoursesPackageToJson(CoursesPackage instance) =>
    <String, dynamic>{
      'studentid': instance.studentid,
      'coursesList': instance.coursesList,
    };
