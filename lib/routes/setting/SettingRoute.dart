/// 设置自动配置5\7视图还是手动保存

// import 'package:flutter/material.dart';
// import 'package:uni_campus/utils/updateUtil.dart';
// import 'package:uni_campus/utils/dateCalculator.dart';
// import 'package:flustars/flustars.dart';
//
// class SettingRoute extends StatelessWidget{
//
//   void checkUpdate(BuildContext context){
//     UpdateUtil update=UpdateUtil(context);
//     update.checkUpdate(MANUAL_CHECK);
//   }
//
//   void getWeekIndex()async{
//     DateCalculator date = new DateCalculator();
//     date.calculateWeekIndex();
//     LogUtil.v("[Date] ${DateCalculator.weekIndex}, ${DateCalculator.dayIndex}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         flexibleSpace:
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [Color(0xFF93DBFF), Color(0xFF0042FF)],
//             ),
//           ),
//         ),
//         // backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: Text("设置"),
//       ),
//       body:
//           Container(
//             child:
//             ListView(
//               children: <Widget>[
//                 TextButton(
//                   onPressed: (){
//                     checkUpdate(context);
//                   },
//                   child: Text('update'),
//                 ),
//               ],
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //     icon: Icon(Icons.person),
//               //   ),
//               //   // Divider(),
//               //   SelectTextItem(
//               //     title: '密保手机号',
//               //     content: '131****3987',
//               //     textAlign: TextAlign.end,
//               //     contentStyle: TextStyle(
//               //       fontSize: 18,
//               //       color: Color(0xFF333333),
//               //     ),
//               //   ),
//               //   SelectTextItem(
//               //     title: '消息通知',
//               //   ),
//               //   SelectTextItem(
//               //     height: 35,
//               //     title: '清空缓存',
//               //     content: '1024k',
//               //     isShowArrow: false,
//               //     textAlign: TextAlign.end,
//               //     contentStyle: new TextStyle(
//               //       fontSize: 18,
//               //       color: Color(0xFF333333),
//               //     ),
//               //   ),
//               //   SelectTextItem(
//               //     title: '意见反馈',
//               //     content: '一个很长很长的内容一个很长很长的内容一个很长很长的内容一个很长很长的内容一个很长很长的内容',
//               //   ),
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '夜间模式',
//               //   ),
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //   ),
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //   ),
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //   ),
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //   ),
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //   ),
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //   ),
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //   ),                SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //   ),
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //   ),
//               //   SelectTextItem(
//               //     // icon: Icon(Icons.lock),
//               //     // imageName: 'assets/images/账号密码icon.png',
//               //     title: '修改密码',
//               //   ),
//               //
//               //
//               // ],
//             ),
//           ),
//       // ListView(
//       //   children: <Widget>[
//       //     SelectTextItem(
//       //       // icon: Icon(Icons.lock),
//       //       // imageName: 'assets/images/账号密码icon.png',
//       //       title: '修改密码',
//       //     ),
//       //     SelectTextItem(
//       //       title: '密保手机号',
//       //       content: '131****3987',
//       //       textAlign: TextAlign.end,
//       //       contentStyle: TextStyle(
//       //         fontSize: 18,
//       //         color: Color(0xFF333333),
//       //       ),
//       //     ),
//       //     SelectTextItem(
//       //       title: '消息通知',
//       //     ),
//       //     SelectTextItem(
//       //       height: 35,
//       //       title: '清空缓存',
//       //       content: '1024k',
//       //       isShowArrow: false,
//       //       textAlign: TextAlign.end,
//       //       contentStyle: new TextStyle(
//       //         fontSize: 18,
//       //         color: Color(0xFF333333),
//       //       ),
//       //     ),
//       //     SelectTextItem(
//       //       title: '意见反馈',
//       //       content: '一个很长很长的内容一个很长很长的内容一个很长很长的内容一个很长很长的内容一个很长很长的内容',
//       //     ),
//       //   ],
//       // ),
//     );
//       // Column(
//       //   children: [
//       //     ElevatedButton(child: Text("update"),onPressed: ()=>callUpdateUtil(context)),
//       //     ElevatedButton(child: Text("date"),onPressed: ()=>getWeekIndex(context)
//       //     ),
//       //     // ElevatedButton(child: Text("shared_preferences"),onPressed: tmpFuc),
//       //     // ElevatedButton(child: Text("shared_preferences"),onPressed: tmpFuc),
//       //
//       //   ],
//       // ),
//   }
// }
//
