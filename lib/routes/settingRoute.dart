import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import 'package:uni_campus/utils/updateUtil.dart';
import 'package:uni_campus/utils/dateCalculator.dart';
// import 'dart:io';

class SettingRoute extends StatelessWidget {
  void callUpdateUtil(BuildContext context) {
    UpdateUtil update = UpdateUtil(context);
    update.checkUpdate(MANUAL_CHECK);
  }

  void getWeekIndex(BuildContext context) async {
    // List<int> ls=await DateUtil.calculateWeekIndex(context);
    // DateCalculator date = new DateCalculator();
    await DateCalculator.calculateWeekIndex();
    LogUtil.v("[Date] ${DateCalculator.weekIndex}, ${DateCalculator.dayIndex}");
    // LogUtil.v(ls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("设置"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              child: Text("update"), onPressed: () => callUpdateUtil(context)),
          ElevatedButton(
              child: Text("date"), onPressed: () => getWeekIndex(context)),
          // ElevatedButton(child: Text("shared_preferences"),onPressed: tmpFuc),
          // ElevatedButton(child: Text("shared_preferences"),onPressed: tmpFuc),
        ],
      ),
    );
  }
}
