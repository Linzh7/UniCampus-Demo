import 'dart:convert';
import 'dart:io';
import 'package:flustars/flustars.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:uni_campus/Resource/urls.dart';
import 'package:uni_campus/utils/dateCalculator.dart';
import 'package:uni_campus/widgets/Dialog.dart';

final int AUTO_CHECK = 1;
final int MANUAL_CHECK = 2;

class UpdateUtil {
  BuildContext context;
  UpdateUtil(this.context);

  /// =============================
  /// @description: 获取SP里存的所有可能的东西
  /// @params int checkMethod 为1则为自动更新，会检查日期，为2则为手动更新，强制检查最新版本
  /// @return Future(null)
  /// @author: Linzh
  /// @date 2022-05-06 1:59 PM
  /// =============================
  Future checkUpdate(int checkMethod) async {
    LogUtil.v("[Update] Update processing...");
    DateTime currentTime = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastCheckUpdateString =
        await prefs.getString("lastCheckUpdate") ?? 'N';
    // LogUtil.v('[Debug] lastCheckUpdateString is ${lastCheckUpdateString}');
    DateTime lastCheckUpdate;
    // if the last update string is not NULL, it means that we have checked once at least
    if (lastCheckUpdateString != 'N') {
      lastCheckUpdate = DateTime.parse(lastCheckUpdateString); // save the check date, we need use it to calculate if it's necessary 2 start another check
    } else {
      // this is the first open, assume that the last check date is 2021-1-1
      lastCheckUpdate = DateTime(2021);
    }
    LogUtil.v("[Update] last check time: " + lastCheckUpdate.toString());
    // get the newest semester info
    try {
      Dio dio = new Dio();
      // semester start info
      String url;
      Response response;
      if(DateCalculator.startYear < 2000 || DateTime(DateCalculator.startYear,DateCalculator.startMonth,1).isBefore(DateTime.now().subtract(Duration(days: 120)))){
        url = CALENDER_CHECK;
        response = await dio.get(url);
        var data;
        if (response.statusCode == 200) { // got info
          data = jsonDecode(response.toString());
          prefs.setInt('SemesterStartYear', data['year']);
          prefs.setInt('SemesterStartMonth', data['month']);
          prefs.setInt('SemesterStartDay', data['day']);
          DateCalculator.semesterStartDate = DateTime(data['year'], data['month'], data['day']);
          // LogUtil.v('[Debug] start date set done.');
        }else{
          LogUtil.e("[Date] Error: Cannot get semester info, ${data}");
        }
        LogUtil.v("[Date] Server start at ${data['year']}.${data['month']}.${data['day']}");
      }


      /// check update
      await Future.delayed(Duration(milliseconds: 250)); // otherwise, server will reset the connect
      // String url;
      if (Platform.isAndroid) {
        url = UPDATE_INDEX + 'android.json';
      } else {
        url = UPDATE_INDEX + 'ios.json';
      }
      LogUtil.v(
          "[Update] have Internet access, and get version info. URL: $url");
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // Dio dio = Dio();
      response = await dio.get(url);
      if (response.statusCode == 200) { // got info
        int currentVersion = versionParse2Int(packageInfo.version);
        var data = jsonDecode(response.toString());
        int remoteVersion = versionParse2Int(data['version']);
        int forcePush = data['forcePush'];
        int buildNumber = data['buildNumber'];
        LogUtil.v('[Update] Remote version: ${data['version']}, buildNumber: ${buildNumber}. Local: ${packageInfo.version}, buildNumber: ${int.parse(packageInfo.buildNumber)}');
        // if one of [last check is 7 days before, user wanna download the newest version, we want them download this version right now] is true, then
        if (currentTime.add(Duration(days: -7)).isAfter(lastCheckUpdate) || checkMethod == MANUAL_CHECK || forcePush > 0) {
          prefs.setString("lastCheckUpdate", currentTime.toString());
          if (remoteVersion > currentVersion || (forcePush > 0 && buildNumber > int.parse(packageInfo.buildNumber))) {
            prefs.setString("lastChekUpdate", currentTime.toString());
            showUpdateDialog(data);
          }
        } else {
          LogUtil.v("[Update] just check, skip.");
        }
      }
    } catch (DioError, error) {
      LogUtil.e('[Update] DIO error: ${error.toString()}');
      if (Platform.isAndroid) {
        showDialog(
          context: context,
          builder: (context) => mDialog(
            "无网络连接或服务器状态异常",
            Text("请检查网络设置。\n若确认网络设置正常，请联系管理员检查服务器状态。\n错误信息：${error.toString()}"),
            [
              TextButton(
                child: Text("知道了"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  onPressed: () {
                    launch("https://jq.qq.com/?_wv=1027&k=iRfFDOOv");
                    Navigator.of(context).pop();
                  },
                  child: Text("联系管理员"))
            ],
          ),
        );
      }
    }
  }
  /// =============================
  /// @description: 显示更新对话框
  /// @params Map info 包含了题目、内容等信息的map，在json里写的
  /// @return null
  /// @author: Linzh
  /// @date 2022-05-06 2:09 PM
  /// =============================
  // the dialog that show the info of this version, json file example below
  void showUpdateDialog(Map info) async {
    showDialog(
      context: context,
      builder: (context) => mDialog(info['title'], Text(info['content']), [
        TextButton(
          child: Text("下次再说"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
            child: Text("立即更新"),
            onPressed: () async {
              if (info['url'] != '') {
                await launch(info['url']);
              }
              ;
            }),
      ]),
    );
  }

  /// =============================
  /// @description: 把str的版本号变成int，使之可以比较
  /// @params String dotVersion 字符串形式的版本号
  /// @return int
  /// @author: Linzh
  /// @date 2022-05-06 2:10 PM
  /// =============================
  // parse the version String into int, consider that
  int versionParse2Int(String dotVersion) {
    List<String> ls = dotVersion.split(".");
    int versionInt = int.parse(ls[0]) * 100000000 +
        int.parse(ls[1]) * 10000 +
        int.parse(ls[2]);
    return versionInt;
  }
}


// ios.json
//{
//   "version": "1.0.0",
//   "title": "这里是标题",
//   "content": "这里是内容",
//   "url": "具体的下载地址，一定到xxx.apk或者商店页面",
//   "forcePush" : 0,
//   "buildNumber": 10049
// }