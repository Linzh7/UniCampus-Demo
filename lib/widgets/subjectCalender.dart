// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uni_campus/models/settings.dart';
// import 'package:flustars/flustars.dart';
// import 'package:uni_campus/widgets/halfDayCoursesProvider.dart';
// import 'package:uni_campus/utils/dateCalculator.dart';
//
// class SubjectCalender extends StatefulWidget {
//   SubjectCalender(this.childWidth);
//
//   final double childWidth;
//
//   @override
//   _SubjectCalenderState createState() => _SubjectCalenderState();
//
// }
// class _SubjectCalenderState extends State<SubjectCalender> {
//   // bool refresh=false;
//   // final TextStyle _dayLabelStyle = TextStyle(letterSpacing: 0, wordSpacing: 0, fontSize: 18);
//   int weekIndex= DateCalculator.weekIndex;
//   int daysPerWeek = Settings.daysPerWeek;
//   @override
//   void initState() {
//     super.initState();
//     LogUtil.v("[SC] initState");
//   }
//
//   setSetting()async{
//     SharedPreferences sp = await SharedPreferences.getInstance();
//     LogUtil.v("[Setting] DaysPerWeek 5-day mode is $isFiveDayMode.");
//     sp.setInt("DaysPerWeek", isFiveDayMode?5:7);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     LogUtil.v("[Debug] weekIndex:${weekIndex}, daysPerWeek:${daysPerWeek}, childWidth:${widget.childWidth}");
//     // DateTime newDateTime;
//     return
//   }
//
//   Widget _divider(String text){
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: new BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black54,
//             offset: Offset(2.0, 2.0),
//             blurRadius: 4,
//             spreadRadius: 1)
//         ]),
//       width: MediaQuery.of(context).size.width * 0.95,
//       alignment: Alignment.center,
//       child: Text(text),
//     );
//   }
// }
