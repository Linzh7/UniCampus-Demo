import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  final String name;
  final String time;
  final String content;
  final bool group;
  final String avatarURL;

  Message(
      {required this.time,
      required this.group,
      required this.avatarURL,
      required this.content,
      required this.name});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

List<Message> demoMessageData = [
  new Message(
    name: "超级锅贴",
    time: "01-20",
    content: "锅贴糊了，等会",
    group: false,
    avatarURL: "/images/cat1.jpeg",
  ),
  new Message(
    name: "汤饭世家",
    time: "01-13",
    content: "停水了，等会",
    group: false,
    avatarURL: "/images/cat1.jpeg",
  ),
  new Message(
    name: "素食吧",
    time: "01-02",
    content: "我们新进了一批上好牛肉",
    group: true,
    avatarURL: "/images/cat1.jpeg",
  ),
  new Message(
    name: "炒饭",
    time: "12-30",
    content: "春节快乐！",
    group: false,
    avatarURL: "/images/cat1.jpeg",
  ),
];
