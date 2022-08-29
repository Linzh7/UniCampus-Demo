// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      time: json['time'] as String,
      group: json['group'] as bool,
      avatarURL: json['avatarURL'] as String,
      content: json['content'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'name': instance.name,
      'time': instance.time,
      'content': instance.content,
      'group': instance.group,
      'avatarURL': instance.avatarURL,
    };
