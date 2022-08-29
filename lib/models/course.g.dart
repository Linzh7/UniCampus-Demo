// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      json['cname'] as String,
      json['cday'] as int,
      json['cstartweek'] as int,
      json['cendweek'] as int,
      json['cstartnumber'] as int,
      json['cendnumber'] as int,
      json['clocation'] as String,
      json['cteacher'] as String,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'cname': instance.cname,
      'clocation': instance.clocation,
      'cstartnumber': instance.cstartnumber,
      'cendnumber': instance.cendnumber,
      'cday': instance.cday,
      'cstartweek': instance.cstartweek,
      'cendweek': instance.cendweek,
      'cteacher': instance.cteacher,
    };
