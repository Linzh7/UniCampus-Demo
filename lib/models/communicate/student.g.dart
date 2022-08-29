// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
      json['sname'] as String,
      json['smajor'] as String,
      json['sdepartment'] as String,
      json['sclass'] as String,
      json['ssgrade'] as String,
    );

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'sname': instance.sname,
      'smajor': instance.smajor,
      'sdepartment': instance.sdepartment,
      'sclass': instance.sclass,
      'ssgrade': instance.ssgrade,
    };
