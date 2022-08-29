// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      department: json['department'] as String,
      content: json['content'] as String,
      time: json['time'] as String,
      describe: json['describe'] as String,
      title: json['title'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'department': instance.department,
      'title': instance.title,
      'content': instance.content,
      'time': instance.time,
      'describe': instance.describe,
      'url': instance.url,
    };
