import 'package:flutter/material.dart';

List<Color> colorList = [
  Color(0xeeF6F6F6),
  Color(0xFFFF0000),
  Color(0xFFFF8A80),
  Color(0xFFEA6059),
  Color(0xFFFF80AB),
  Color(0xFFEA94B0),
  Color(0xFFB45772),
  Color(0xFFB966C7),
  Color(0xFFCF5FE7),
  Color(0xFF673AB7),
  Color(0xFF8453DB),
  Color(0xFF3F51B5),
  Color(0xFF596CD5),
  Color(0xFF2196F3),
  Color(0xFF4EAAEE),
  Color(0xFF1188B6),
  Color(0xFF00BCD4),
  Color(0xFF0BADC2),
  Color(0xFF009688),
  Color(0xFF17BDAD),
  Color(0xFF4CAF50),
  Color(0xFF2C9E30),
  Color(0xFF8BC34A),
  Color(0xFFADE071),
  Color(0xFFCDDC39),
  Color(0xFFA8B423),
  Color(0xFFA7981F),
  Color(0xFFAA9D38),
  Color(0xFFFFC107),
  Color(0xFFD0A229),
  Color(0xFFFF9800),
  Color(0xFFDC993D),
  Color(0xFFF87851),
  Color(0xFF795548),
  Color(0xFFB87961),
];


int colorCalculator(String string) {
  int sum = 0;
  List<int> ls = string.codeUnits;
  for (var char in ls) {
    sum = (sum + char) % 200;
  }
  return sum % (colorList.length - 2) + 2;
}
