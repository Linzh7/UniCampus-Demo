import 'dart:math';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:uni_campus/Resource/colorList.dart';
import 'package:uni_campus/models/course.dart';
import 'package:uni_campus/models/database/classListGetter.dart';
import 'package:uni_campus/utils/classIndexUtil.dart';
import 'package:uni_campus/widgets/ClassCube.dart';

class HalfDayCoursesProvider extends StatefulWidget {
  final int week;
  final int daysPerWeek;
  final double width;
  final int startIndex;
  final int endIndex;

  HalfDayCoursesProvider(
      this.week, this.daysPerWeek, this.width, this.startIndex, this.endIndex);

  @override
  _HalfDayCoursesProvider createState() {
    // LogUtil.v(
    //     '[Debug] HalfDayCoursesProvider init pram: $week, $daysPerWeek...}');
    return _HalfDayCoursesProvider();
  }
}

class _HalfDayCoursesProvider extends State<HalfDayCoursesProvider> {
  final int NO = -2;
  final int DO_NOT_SHOW = -2;
  final int INIT = -1;

  ClassListGetter getter = new ClassListGetter();

  /// =============================
  /// @description: 组装一个上午\下午\晚上的课表
  /// @params null
  /// @return Future<List<List<Widget>>>
  /// @author: Linzh
  /// @date 2022-05-06 2:26 PM
  /// =============================
  Future<List<List<Widget>>> buildClassesWidgetList() async {
    await getter.open();
    List<List<Widget>> result = [];
    // LogUtil.v(
    // "[ClassTable] init. ${widget.week}w, ${widget.startIndex}-${widget.endIndex}, ${widget.daysPerWeek}dpw.");
    /// 需要五天还是七天的
    for (int day = 1; day < widget.daysPerWeek + 1; day++) {
      List<Course> classesList = [];
      try {
        classesList = await getter.getHalfDayClasses(
            day, widget.week, widget.startIndex, widget.endIndex);
        // classesList = await getter.getHalfDayClasses(day, 6, widget.startIndex, widget.endIndex);
      } catch (e) {
        LogUtil.e("[ClassTableDB] Build error: $e");
      }
      // if (day == 5 && widget.startIndex == 1) {
      //   for (int i = 0; i < classesList.length; i++) {
      //     // LogUtil.v("[ClassTableDB] class: ${classesList[i].toJson()}");
      //   }
      // }
      // LogUtil.v("[ClassTableDB] class length: ${classesList.length}");
      List<int> isCourseConflict = [];
      for (int i = 0; i < classesList.length; i++) {
        isCourseConflict.add(INIT);
        // LogUtil.v("[ClassTableDB] class: ${classesList[i].toJson()}");
      }
      for (int i = 0; i < classesList.length; i++) {
        // LogUtil.v("[ClassTableDB] ${classesList.length}");
        for (int j = i+1; j < min(i+2,classesList.length); j++) {
          // if (i == j) {
          //   continue;
          // }
          // LogUtil.v("[ClassTableDB] now: ${i}, $j.");
          if (classIndexUtil.isCourseIndexValid(
              classesList[i], classesList[j])) {
            isCourseConflict[i] = j;
            isCourseConflict[j] = DO_NOT_SHOW;
          }
        }
      }
      List<Widget> dayCourse = [];
      List<int> existClass = [];
      /// 初始化占位列表
      for (int i = 0; i < widget.endIndex - widget.startIndex + 1; i++) {
        existClass.add(INIT);
      }
      /// 如果有课，就记录是什么课；如果有冲突，就记录最长的那个🉑️
      for (int i = 0; i < classesList.length; i++) {
        // if(isCourseConflict[i] == -1){
        //   LogUtil.v('[ClassTable] this course will be skipped: ${classesList[i].toJson()}');
        //   continue;
        // }
        int maxLimit = classesList[i].cendnumber;
        // if(isCourseConflict[i]!=INIT)LogUtil.v('[ClassTable] course ${classesList[i].cname} is conflict, range(${widget.startIndex}, ${max(classesList[i].cendnumber,classesList[isCourseConflict[i]].cendnumber)}).');
        if (isCourseConflict[i] > INIT) {
          maxLimit = max(maxLimit, classesList[isCourseConflict[i]].cendnumber);
          // LogUtil.v('[ClassTable] ${classesList[isCourseConflict[i]].cname} and ${classesList[i].cname}, max:${maxLimit}, ${classesList[isCourseConflict[i]].cendnumber}.');
        }
        // LogUtil.v('[ClassTable] ${classesList[i].cname} maxLimit: ${maxLimit}');
        for (int j = classesList[i].cstartnumber - widget.startIndex; j < maxLimit - widget.startIndex + 1; j++) {
          if (isCourseConflict[i] == DO_NOT_SHOW) break;
          // if(isCourseConflict[i]!=INIT) LogUtil.v("[ClassTable] set ${existClass[j]}=$i, this range(${classesList[i].cstartnumber-widget.startIndex}, ${max(classesList[i].cendnumber,classesList[isCourseConflict[i]].cendnumber)-widget.startIndex+1})");
          // LogUtil.v('[ClassTable] ${classesList[i].cname}, index: $j is true.');
          existClass[j] = i;
        }
      }
      /// 生成cubes，有冲突，也是cube的逻辑解决，这里只负责对没有课的部分添加灰色块块、对有课的插入标准块块
      try {
        for (int i = 0; i < widget.endIndex - widget.startIndex + 1;) {
          if (existClass[i] != INIT) {
            // LogUtil.v('[DEBUG] ${classesList[existClass[i]].cname} in ${day}.');
            if (isCourseConflict[existClass[i]] > INIT) {
              // LogUtil.v(
              //     '[debug] 123123${classesList[isCourseConflict[existClass[i]]].cname},${classesList[isCourseConflict[existClass[i]]].cendnumber}');
              dayCourse.add(ClassCube(
                classesList[existClass[i]].cname,
                classesList[existClass[i]].clocation,
                widget.width,
                classesList[existClass[i]].cstartnumber,
                classesList[existClass[i]].cendnumber,
                day,
                classesList[existClass[i]].cstartweek,
                classesList[existClass[i]].cendweek,
                1, true,
                classesList[isCourseConflict[existClass[i]]].cname,
                classesList[isCourseConflict[existClass[i]]].clocation,
                classesList[isCourseConflict[existClass[i]]].cstartnumber,
                classesList[isCourseConflict[existClass[i]]].cendnumber,
              ));
              i = max(classesList[existClass[i]].cendnumber,
                      classesList[isCourseConflict[i]].cendnumber) -
                  widget.startIndex +
                  1;
            } else {
              dayCourse.add(ClassCube(
                  classesList[existClass[i]].cname,
                  classesList[existClass[i]].clocation,
                  widget.width,
                  classesList[existClass[i]].cstartnumber,
                  classesList[existClass[i]].cendnumber,
                  day,
                  classesList[existClass[i]].cstartweek,
                  classesList[existClass[i]].cendweek,
                  colorCalculator(classesList[existClass[i]].cname),
                  false,
                  '',
                  '',
                  0,
                  0,));
              i = classesList[existClass[i]].cendnumber - widget.startIndex + 1;
            }
          } else {
            // LogUtil.v('[DEBUG] add blank course in ${day}.');
            dayCourse.add(ClassCube(
                "", "", widget.width, 0, 0, day, 0, 0, 0, false, '', '', 0, 0,));
            i++;
          }
        }
      } catch (e) {
        LogUtil.e("[ClassTable] Error: " + e.toString());
      }
      // LogUtil.v("[ClassTable] one of half-day done with ${classesList.length} records.");
      result.add(dayCourse);
    }
    // LogUtil.v("[ClassTable] half-day done with ${result.length} records.");
    return result;
  }

  @override
  void initState() {
    getter.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: buildClassesWidgetList(),
      builder:
          (BuildContext context, AsyncSnapshot<List<List<Widget>>> snapshot) {
        if (snapshot.hasData) {
          List<List<Widget>>? courseList = snapshot.data;
          // print('[debug] courseList length: ${courseList![0].toString()}');
          if (courseList == null) {
            return SizedBox();
          }
          if (courseList.length == 5) {
            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: courseList[0],
              ),
              Column(
                children: courseList[1],
              ),
              Column(
                children: courseList[2],
              ),
              Column(
                children: courseList[3],
              ),
              Column(
                children: courseList[4],
              ),
            ]);
          } else if (courseList.length == 7) {
            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: courseList[0],
              ),
              Column(
                children: courseList[1],
              ),
              Column(
                children: courseList[2],
              ),
              Column(
                children: courseList[3],
              ),
              Column(
                children: courseList[4],
              ),
              Column(
                children: courseList[5],
              ),
              Column(
                children: courseList[6],
              ),
            ]);
          } else {
            return Text("Error.");
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}
