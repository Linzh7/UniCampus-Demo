import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:home_widget/home_widget.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uni_campus/Resource/colorList.dart';
import 'package:uni_campus/models/course.dart';
import 'package:uni_campus/models/database/classListGetter.dart';
import 'package:uni_campus/common/settings.dart';
import 'package:uni_campus/Resource/classIndexMap.dart';
import 'package:uni_campus/utils/dateCalculator.dart';
import 'package:flustars/flustars.dart';
import 'package:uni_campus/utils/notificationUtil.dart';
import 'package:uni_campus/widgets/ClassCard.dart';

/// Assemble Card and provide notification

class ClassCardList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClassCardListState();
}

class _ClassCardListState extends State<ClassCardList> {
  ClassListGetter classList = new ClassListGetter();
  List<Course> todayList = [];
  List<Course> tomorrowList = [];

  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Future<List<Widget>> buildClassesWidgetList() async {
    // int count=0;
    // LogUtil.v("[debug] initFinFlag is ${Settings.initFinFlag}");
    await DateCalculator.dateInitCheck();
    List<Widget> result = [];
    LogUtil.v("[CardList] init....");
    todayList = [];
    bool isEndOfWeek = DateCalculator.dayIndex + 1 > 7;
    try {
      await classList.open();
      todayList = await classList.getHalfDayClasses(
          DateCalculator.dayIndex, DateCalculator.weekIndex, 1, 13);
      _sendData();
      tomorrowList = await classList.getHalfDayClasses(
          isEndOfWeek ? 1 : DateCalculator.dayIndex + 1,
          isEndOfWeek ? DateCalculator.weekIndex + 1 : DateCalculator.weekIndex,
          1,
          13);
    } catch (e) {
      LogUtil.e("[Database] Error while opening: " + e.toString());
    }
    // _isCoursesCalculated = true;
    try {
      result.add(Container(
        margin: EdgeInsets.all(8.0),
        height: 30,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF93DBFF), Color(0xFF0042FF)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // border: Border.all(color: Colors.blue,width: 1),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0, 2),
                  blurRadius: 1,
                  spreadRadius: 1
                  )
            ]),
        child: Text(
          "Today",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xE6FFFFFF),
          ),
        ),
      ));
      // result.add(Divider());
      // result.add(Text("当日课程",style: TextStyle(fontSize: 20,),));
      // result.add(Divider());
      if (todayList.length > 0) {
        for (int i = 0; i < todayList.length; i++) {
          result.add(ClassCard(
            todayList[i].cname,
            todayList[i].clocation,
            DateCalculator.dayIndex,
            todayList[i].cstartnumber,
            todayList[i].cendnumber,
            todayList[i].cstartweek,
            todayList[i].cendweek,
            todayList[i].cteacher,
            colorCalculator(todayList[i].cname),
          ));
        }
      } else {
        result.add(SizedBox(
          height: 18,
        ));
        result.add(Container(
          width: MediaQuery.of(context).size.width * 0.87,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 25,
                    spreadRadius: -4,
                    offset: Offset(0, 8))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              "images/HomePage/relax.jpg",
              fit: BoxFit.fitWidth,
            ),
          ),
        ));
        result.add(SizedBox(
          height: 18,
        ));
      }
      result.add(Container(
        margin: EdgeInsets.all(8.0),
        height: 30,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF93DBFF), Color(0xFF0042FF)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            // border: Border.all(color: Colors.blue,width: 1),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0, 2),
                  blurRadius: 1,
                  spreadRadius: 1
                  )
            ]),
        child: Text(
          "Next Day",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xE6FFFFFF),
          ),
        ),
      ));
      if (tomorrowList.length > 0) {
        for (int i = 0; i < tomorrowList.length; i++) {
          result.add(ClassCard(
            tomorrowList[i].cname,
            tomorrowList[i].clocation,
            isEndOfWeek ? 1 : DateCalculator.dayIndex + 1,
            tomorrowList[i].cstartnumber,
            tomorrowList[i].cendnumber,
            tomorrowList[i].cstartweek,
            tomorrowList[i].cendweek,
            tomorrowList[i].cteacher,
            colorCalculator(tomorrowList[i].cname),
          ));
        }
      } else {
        result.add(SizedBox(
          height: 18,
        ));
        result.add(Container(
          width: MediaQuery.of(context).size.width * 0.87,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 25,
                    spreadRadius: -4,
                    offset: Offset(0, 8))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              "images/HomePage/relax.jpg",
              fit: BoxFit.fitWidth,
            ),
          ),
        ));
        result.add(SizedBox(
          height: 18,
        ));
      }
    } catch (e) {
      LogUtil.e("[CardList] Error while adding" + e.toString());
    }
    // LogUtil.v(
        // "[CardList] ${DateCalculator.weekIndex}w-${DateCalculator.dayIndex}d with today:${todayList.length}, tomorrowList:${tomorrowList.length}.");
    return result;
  }

  _updateWidget() async {
    try {
      if(Platform.isIOS){
        HomeWidget.setAppGroupId('group.cn.wecreatetogether.campus');
      }
      HomeWidget.updateWidget(
          name: 'CoursesListProvider', iOSName: 'CoursesListWidget');//'CoursesListWidget');
      LogUtil.v("[HomeWidget] Home screen widget update.");
    } on PlatformException catch (exception) {
      LogUtil.v('Error Updating Widget. $exception');
    }
  }

  _setNotificationList(){
    NotificationUtil notification = NotificationUtil();
    DateTime today = DateTime.now();
    for(var item in todayList){
      DateTime targetDateTime = DateTime(today.year, today.month, today.day, NotificationHourMap[item.cstartnumber]!, NotificationMinuteMap[item.cstartnumber]!);
      if(targetDateTime.isAfter(today)){
        LogUtil.v("[Notification] today add ${item.cname} at ${today.month}.${today.day} ${NotificationHourMap[item.cstartnumber]!}:${NotificationMinuteMap[item.cstartnumber]!}");
        notification.scheduleNotification(
            item.cname,
            "Location: ${item.clocation}\n Time: ${startIndex2TimeMap[item.cstartnumber]}-${endIndex2TimeMap[item.cendnumber]}",
            targetDateTime);
        break;
      }
    }
  }

  _sendData() async {
    ClassListGetter courseGetter = ClassListGetter();
    List<Course> ls = await courseGetter.getAllClasses();
    if (ls.length != 0) {
      _setNotificationList();
      String data = '';
      for (var ele in todayList) {
        data +=
        '${ele.cname};${ele.clocation} ${startIndex2TimeMap[ele.cstartnumber]}-${endIndex2TimeMap[ele.cendnumber]};';
      }
      if (todayList.length == 0) {
        data += 'No course today; ;QWQ; ; ; ; ; ; ; ; ; ; ;';
      } else {
        data += '; ; ; ; ; ; ; ; ; ; ; ;';
      }
      LogUtil.v("[HomeWidget] widget data: $data");
      HomeWidget.saveWidgetData<String>('data', data);
      LogUtil.v("[HomeWidget] Home screen widget data saved.");
      _updateWidget();
    }else{
      LogUtil.v("[HomeWidget] no data, widget doesn't update.");
      LogUtil.v("[Notification] no data, Notification doesn't be created.");
    }
  }

  // _TMP(){
  //   LogUtil.v("[Notification] TMP.");
  // }

  @override
  Widget build(BuildContext context) {
    // _TMP();
    return FutureBuilder(
      future: buildClassesWidgetList(),
      builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
        if (snapshot.hasData) {
          List<Widget> courseList = snapshot.data??[];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: courseList,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
