import 'package:flustars/flustars.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationUtil{
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  /// =============================
  /// @description: 建立通知channel
  /// @params null
  /// @return null
  /// @author: Linzh
  /// @date 2022-05-06 2:19 PM
  /// =============================
  NotificationUtil(){
    var initializationSettingsAndroid = new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    LogUtil.v("[NotificationUtil] init.");
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Shanghai"));
  }

  /// =============================
  /// @description: 显示课程通知
  /// @params String title 课程名称
  /// @params String info 课程内容
  /// @return Future<>
  /// @author: Linzh
  /// @date 2022-05-06 2:20 PM
  /// =============================
  Future<void> showNotification(String title, String info) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('UniCampus', 'UniCampus',
      channelDescription: 'NextClassNotification',
      // importance: Importance.defaultImportance,
      // priority: Priority.high,
      // ticker: 'ticker'
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, info, platformChannelSpecifics, payload: '');
  }

  /// =============================
  /// @description: 定时显示课程通知
  /// @params String title 课程名称
  /// @params String info 课程内容
  /// @params DateTime dateTime 显示时间
  /// @return Future<>
  /// @author: Linzh
  /// @date 2022-05-06 2:21 PM
  /// =============================
  Future<void> scheduleNotification(String title, String info, DateTime dateTime) async {
    // print("[TIMEZONE] ${tz.local}");
    try{
      await flutterLocalNotificationsPlugin.zonedSchedule(
          0, title, info, tz.TZDateTime.from(dateTime, tz.local),
          const NotificationDetails(
              android: AndroidNotificationDetails('UniCampus', 'UniCampus',
                  channelDescription: 'NextClassNotification')),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
    }catch(e){
      LogUtil.e("[ScheduleNotification] ${e}, time: ${dateTime.toString()}");
    }
  }
}
