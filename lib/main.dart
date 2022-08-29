import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_campus/resource/urls.dart';
import 'package:uni_campus/routes/Routes.dart';
import 'package:flutter/services.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uni_campus/utils/dateCalculator.dart';
import 'common/settings.dart';


Future<void> main() async {
  runApp(UniCampus());
  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn =
  //         'https://xxxxxxx.ingest.sentry.io/xxxxx';
  //   },
  //   appRunner: () => runApp(UniCampus()),
  // );
}

class UniCampus extends StatelessWidget {
  /// =============================
  /// @description: 给导航栏与状态栏显示设定颜色
  /// @param: null
  /// @return: null
  /// @author: Linzh
  /// @date 2022-05-06 1:51 PM
  /// =============================
  initOutlook() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ));
    }
    LogUtil.v("[Init-Outlook] start.");
  }

  // /// =============================
  // /// @description: 获取在SP里的学期开始时间
  // /// @params: null
  // /// @return: Future<List<int>>
  // /// @author: Linzh
  // /// @date 2022-05-06 1:58 PM
  // /// =============================
  // static Future<List<int>> getInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return [
  //     prefs.getInt('SemesterStartYear') ?? -1,
  //     prefs.getInt('SemesterStartMonth') ?? -1,
  //     prefs.getInt('SemesterStartDay') ?? -1
  //   ];
  // }

  /// =============================
  /// @description: 获取SP里存的所有可能的东西
  /// @params: null
  /// @return: null
  /// @author: Linzh
  /// @date 2022-05-06 1:59 PM
  /// =============================
  loadSps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // first start semester check.
    int startYear = await prefs.getInt('SemesterStartYear') ?? -1;
    int startMonth = await prefs.getInt('SemesterStartMonth') ?? -1;
    if(startYear == -1 || DateTime(startYear, startMonth, 1).isBefore(DateTime.now().subtract(Duration(days: 120)))){
      LogUtil.v('[Init-SP] No semester start info.');
      await getSemesterStartInfo(prefs);
    }else{
      DateCalculator.startYear = startYear;
      DateCalculator.startMonth = startMonth;
      DateCalculator.startDay = await prefs.getInt('SemesterStartDay') ?? -1;
    }
    DateCalculator.calculateWeekIndex();
    // initDate();
    Settings.daysPerWeek = prefs.getInt("DaysPerWeek") ?? 5;
    LogUtil.v('[Init-SP]  DaysPerWeek: ${Settings.daysPerWeek}');
    Settings.token = prefs.getString("token") ?? "";
    LogUtil.v('[Init-SP]  token: ${Settings.token}');
  }

  /// =============================
  /// @description: 获取学期开始时间
  /// @params: null
  /// @return: null
  /// @author: Linzh
  /// @date 2022-05-06 2:12 PM
  /// =============================
  getSemesterStartInfo(SharedPreferences prefs)async{
    LogUtil.v('[Init-SP] Getting info...');
    String url = CALENDER_CHECK;
    Dio dio = new Dio();
    Response response = await dio.get(url);
    var data;
    if (response.statusCode == 200) {
      LogUtil.v('[Init-SP] Setting...');
      data = jsonDecode(response.toString());
      prefs.setInt('SemesterStartYear', data['year']);
      prefs.setInt('SemesterStartMonth', data['month']);
      prefs.setInt('SemesterStartDay', data['day']);
      DateCalculator.semesterStartDate = DateTime(data['year'], data['month'], data['day']);
      DateCalculator.startYear = data['year'];
      DateCalculator.startMonth = data['month'];
      DateCalculator.startDay = data['day'];
      LogUtil.v("[Date] Server start at ${data['year']}.${data['month']}.${data['day']}");
    }else{
      LogUtil.e("[Date] Error: Server cannot connect. ${data}");
    }
  }

  @override
  Widget build(BuildContext context) {
    LogUtil.init(tag: '', isDebug: false);
    loadSps();
    initOutlook();
    LogUtil.v("[APP] fin, start material app.");
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: Routes.routers,
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('zh', 'CN'),
        ]);
  }
}
