import 'package:uni_campus/models/course.dart';

class classIndexUtil {
  /// =============================
  /// @description: 检查两个课程是否有冲突
  /// @params Course a 第一个课程
  /// @params Course b 第二个课程
  /// @return bool
  /// @author: Linzh
  /// @date 2022-05-06 2:12 PM
  /// =============================
  static bool isCourseIndexValid(Course a, Course b) {
    if (a.cday != b.cday) return false;
    if (a.cstartweek > b.cendweek || a.cendweek < b.cstartweek) return false;
    if (a.cstartnumber > b.cendnumber || a.cendnumber < b.cstartnumber)
      return false;
    return true;
  }
}

