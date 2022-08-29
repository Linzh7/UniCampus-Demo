import 'package:html/parser.dart';
import 'package:flustars/flustars.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_campus/models/course.dart';

class WebUtil {

  /// =============================
  /// @description: 设置人类名称
  /// @params String name 人类的名字
  /// @return null
  /// @author: Linzh
  /// @date 2022-05-06 2:21 PM
  /// =============================
  static setName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Name', name);
    // Settings.name = name;
    // LogUtil.v('[Web] settings.name: ${Settings.name}.');
  }

  //TODO: 一开始没用正则，因为正则比split消耗资源，但后来想想，已经分解到几十个字符的情况下，差不太多，正则的容错之类的高一些，可以把下面使用split提取的内容，变成正则提取

  /// =============================
  /// @description: 本科生课表解析
  /// @params String rawData HTML扒下来的所有东西
  /// @return [courseList, errorInfo] 如果没啥问题，就获得一堆课程，如果有问题，就获得当前能解析的部分和不能解析部分对应的错误信息
  /// @author: Linzh
  /// @date 2022-05-06 2:21 PM
  /// =============================
  static List<dynamic> getCoursesListFromHTML(String rawData) {
    List<Course> courseList = [];
    String errorInfo = "";
    try {
      var document = parse(rawData);
      var nameData = document
          .getElementsByClassName('main-per-name')[0]
          .text
          .replaceAll('\t', '')
          .replaceAll('\n', '');
      String name = nameData.substring(2, nameData.length - 2);
      LogUtil.v("get name ${nameData}");
      // LogUtil.v('[Web] Name: $name');
      // setName(name);
      var rows;
      try{
        rows = document
            .getElementsByClassName('table-class-even')[1]
            .getElementsByTagName('tr');
      }catch(e){
        rows = document
            .getElementsByClassName('table-class-even')[0]
            .getElementsByTagName('tr');
      }
      int timeIndex = 0;
      for (var row in rows) {
        int dayIndex = 0;
        var columns = row.getElementsByTagName('td');
        for (var column in columns) {
          String rawData = column.text;
          if (rawData == '上午' || rawData == '下午' || rawData == '晚上') {
            continue;
          } else if (RegExp('^[第]..[大节]\$').hasMatch(rawData)) {
            switch (rawData[1]) {
              case '一':
                timeIndex = 1;
                continue;
              case '二':
                timeIndex = 2;
                continue;
              case '三':
                timeIndex = 3;
                continue;
              case '四':
                timeIndex = 4;
                continue;
              case '五':
                timeIndex = 5;
                continue;
            }
          }
          dayIndex++;
          if (rawData == '') {
            // LogUtil.v("[Parse] $timeIndex in $dayIndex, no course.");
            continue;
          }
          var courses = column.getElementsByTagName('div');
          for (var course in courses) {
            String courseInfo = "";
            try {
              rawData = course.text.replaceAll('\t', '').replaceAll('\n', '');
              courseInfo = rawData.substring(0, 15);
              // LogUtil.v('[web] raw data: ${rawData}');
              List<String> courseStringList = rawData.split('@');
              String className = courseStringList[0];
              courseInfo = className;
              courseStringList = courseStringList[1].split('◇第');
              String classLocation = courseStringList[0];
              courseStringList = courseStringList[1].split('周(');
              String weekInfoString = courseStringList[0];
              courseStringList = courseStringList[1].split('-');
              int classStartIndex = int.parse(courseStringList[0]);
              int classEndIndex = int.parse(courseStringList[1].split('节)')[0]);
              courseStringList = weekInfoString.split('周,');
              for (int i = 0; i < courseStringList.length; i++) {
                List<String> weekInfoStringList = courseStringList[i].split('-');
                courseList.add(Course(
                    className,
                    dayIndex,
                    int.parse(weekInfoStringList[0]),
                    int.parse(weekInfoStringList[1]),
                    classStartIndex,
                    classEndIndex,
                    classLocation,
                    ''));
              }
            }catch(e){
              LogUtil.e("[ImportError] import: ${e} at ${courseInfo}");
              errorInfo += courseInfo + " ";
            }
          }
        }
      }
      // LogUtil.v('length: ${courseList.length}');
    } catch (e) {
      LogUtil.e("[ImportError] final: ${e}");
      if(rawData.contains("第一大节")){
        _sendCrashReport(e.toString(), rawData);
      }
      return [courseList, errorInfo];
    }
    return [courseList, errorInfo];
  }

  static _sendCrashReport(String error, String rawData) async {
    Sentry.captureUserFeedback(SentryUserFeedback(
      eventId: await Sentry.captureMessage(
          'Course Import Report, ${DateTime.now().toIso8601String()}'),
      comments: "Error: $error;\nRawData:\n$rawData",
      email: "unknown",
      name: "unknown",
    ));
  }

  /// =============================
  /// @description: 研究生课表解析
  /// @params String rawData HTML扒下来的所有东西
  /// @return [courseList, errorInfo] 如果没啥问题，就获得一堆课程，如果有问题，就获得当前能解析的部分和不能解析部分对应的错误信息
  /// @author: Linzh
  /// @date 2022-05-06 2:21 PM
  /// =============================
  static List<dynamic> getPostgraduateCoursesListFromHTML(String rawData) {
    String errorInfo = "";
    List<Course> result = [];
    try {
      var document = parse(rawData);
      String nameString = document
          .getElementsByClassName('head_t_msg')[0]
          .text
          .replaceAll("\n", "")
          .replaceAll(" ", "")
          .split("，")[1]
          .split("！")[0];
      // setName(nameString);
      var data = document
          .getElementsByClassName('WtbodyZlistS')[0]
          .getElementsByTagName('tr');
      for (var row in data) {
        var columns = row.children;
        int dayIndex = 1;
        for (var course in columns.sublist(2)) {
          String courseInfo = "";
          try{
            if (course.text.contains("节")) {
              // String courseInfo = "";
              List<String> courseList = course.text.split("\n\n");
              for (int i = 0; i < courseList.length; i++) {
                List<String> courseData = courseList[i].replaceAll(" ", "").split(
                    "\n");
                if (courseData[0] != "") {
                  courseData.insert(0, "");
                }
                String name = courseData[1];
                // courseInfo += name +" ";
                List<String> tmp = courseData[3].split(":")[1]
                    .replaceAll("节", "").replaceAll("第", "")
                    .split(",");
                int startIndex = int.parse(tmp[0]);
                int endIndex = int.parse(tmp[tmp.length - 1]);
                String location = courseData[5].split(":")[1];
                tmp = courseData[4].split(":");
                if (tmp[1]
                    .split(";")
                    .length == 1 && tmp[1]
                    .split(",")
                    .length == 1) {
                  tmp = tmp[1].split("-");
                  int startWeek = int.parse(tmp[0]);
                  int endWeek = int.parse(tmp[1].replaceAll(RegExp(r'\D'), ''));
                  result.add(Course(
                      name,
                      dayIndex,
                      startWeek,
                      endWeek,
                      startIndex,
                      endIndex,
                      location,
                      ""));
                  LogUtil.v(
                      "$name, $dayIndex, $startWeek, $endWeek, $startIndex, $endIndex");
                } else {
                  if (tmp[1]
                      .split(";")
                      .length > 1) {
                    tmp = tmp[1].split(";");
                  } else if (tmp[1]
                      .split(",")
                      .length > 1) {
                    tmp = tmp[1].split(",");
                  }
                  for (var ele in tmp) {
                    List<String> week = ele.split("-");
                    int startWeek = int.parse(week[0]);
                    int endWeek = int.parse(week[1].split("(")[0]);
                    result.add(Course(
                        name,
                        dayIndex,
                        startWeek,
                        endWeek,
                        startIndex,
                        endIndex,
                        location,
                        ""));
                    LogUtil.v("$name, $dayIndex, $startWeek, $endWeek, $startIndex, $endIndex");
                  }
                }
              }
            }
          }catch(e){
            LogUtil.e("[ImportError] import: ${e} at ${courseInfo}");
            errorInfo += courseInfo + " ";
          }
          dayIndex += 1;
        }
      }
      return [result, errorInfo];
    } catch (e){
      LogUtil.e('[WebParse] Error: $e');
      if(rawData.contains("星期一")){
        _sendCrashReport(e.toString(), rawData);
      }else{
        LogUtil.e("[WebParse] import at main page instead of courses page. orz");
      }
      return [result, errorInfo];
    }
  }
}
