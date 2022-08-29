import 'package:flustars/flustars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateCalculator {
  // 初始化的时候，获取现在的时间
  static DateTime today = DateTime.now();

  // 刚启动，变成-1
  static int _weekIndex = -1;
  static int _dayIndex = -1;
  static int startYear = 0;
  static int startMonth= 0;
  static int startDay = 0;

  /// =============================
  /// @description: 检查现在的日期是否初始化成功
  /// @params null
  /// @return bool
  /// @author: Linzh
  /// @date 2022-05-06 2:13 PM
  /// =============================
  static bool isDateInit(){
    if(_weekIndex == -1 || _dayIndex == -1){
      return false;
    }else{
      return true;
    }
  }

  // get函数，使真正显示不会很怪
  static int get weekIndex {
    if (_weekIndex > 20 || _weekIndex < 1) {
      return 1;
    } else {
      return _weekIndex;
    }
  }
  static int get dayIndex {
    if (_dayIndex > 7 || _dayIndex < 1) {
      return 1;
    } else {
      return _dayIndex;
    }
  }

  // 如果现在还是为初始化，就再等等
  static Future<void> dateInitCheck() async {
    while (_dayIndex == -1 && _weekIndex == -1) {
      LogUtil.v('[DEBUG] date init: ${_dayIndex != -1}');
      await Future.delayed(Duration(microseconds: 25));
    }
    calculateWeekIndex();
  }

  // 初始化的时候，这个随便给一个值
  static DateTime semesterStartDate = DateTime(2021);

  // 从sp里获得学期初始化时间
  static Future<List<int>> getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return [
      prefs.getInt('SemesterStartYear') ?? -1,
      prefs.getInt('SemesterStartMonth') ?? -1,
      prefs.getInt('SemesterStartDay') ?? -1
    ];
  }

  /// =============================
  /// @description: 计算今天是第几周的第几天
  /// @params null
  /// @return [weekIndex, dayIndex] 今天是第几周的第几天
  /// @author: Linzh
  /// @date 2022-05-06 2:14 PM
  /// =============================
  static Future<List<int>> calculateWeekIndex() async {
    LogUtil.v("[Date] Index calculated.");
    // DateTime now = DateTime.now();
    // SharedPreferences sp = await SharedPreferences.getInstance();
    if(startYear*startMonth*startDay==0){
      List<int> info = await getInfo();
      startYear = info[0];
      startMonth = info[1];
      startDay = info[2];
    }
    if (startYear < 0 || startMonth < 0 || startDay < 0) {
      LogUtil.e("[WeekInfo] no semester day data in SP");
      // Error();
    } else {
      semesterStartDate = DateTime(startYear, startMonth, startDay);
    }
    // DateTime lastCheck=DateTime(year,month,day);
    // LogUtil.v("[Date] SP start at $year.$month.$day");
    // semesterStartDate = DateTime(year, month, day);
    LogUtil.v("[Date] startDay: ${semesterStartDate.toString()}");
    var difference = today.difference(semesterStartDate);
    _weekIndex = difference.inDays ~/ 7 + 1;
    _dayIndex = difference.inDays % 7 + 1;
    LogUtil.v("[Date] week: $_weekIndex, day:$_dayIndex");
    return [_weekIndex, _dayIndex];
  }
}
