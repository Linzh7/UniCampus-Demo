import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  final String department;
  final String title;
  final String content;
  final String time;
  final String describe;
  // ignore: non_constant_identifier_names
  final String url;

  // ignore: non_constant_identifier_names
  News(
      {required this.department,
        required this.content,
        required this.time,
        required this.describe,
        required this.title,
        required this.url});

  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
