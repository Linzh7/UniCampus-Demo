// import 'dart:convert';
// import 'dart:io';
// import 'package:flustars/flustars.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uni_campus/models/communicate/communicationPackage.dart';
// import 'package:uni_campus/models/communicate/student.dart';
//
// class SocketUtil {
//   static final String IP_TEST = "118.25.6.183";
//   static final int PORT_TEST = 65432;
//   static final String IP = "47.100.203.176";
//   static final int PORT = 3000;
//   static String? _response;
//
//   static String get response => _response ?? '';
//
//   static send2Server(String ip, int port, String data) {
//     Socket.connect(ip, port).then((socket) {
//       socket.write(data);
//     });
//   }
//
//   static Future loginCommunicate(
//       String university, String studentID, String password) {
//     return new Future.delayed(Duration(seconds: 0), () {
//       return Socket.connect(IP_TEST, PORT_TEST).then((socket) {
//         LogUtil.v('[Login] Connected to: '
//             '${socket.remoteAddress.address}:${socket.remotePort}');
//         LoginPackage data = LoginPackage(university, studentID, password);
//         socket.write("a55a7001".toString() +
//             data.toJson().toString() +
//             "01015aa5".toString());
//         socket.listen((data) {
//           _response = Utf8Decoder().convert(data);
//           LogUtil.v(_response);
//         }, onDone: () {
//           LogUtil.v("[Login] Done");
//           socket.destroy();
//         }, onError: (e) {
//           LogUtil.e("[Login] Error while listening: $e");
//         });
//       });
//     });
//   }
//
//   static void setLoginSharedPreference() async {
//     if (_response!.isEmpty) {
//       LogUtil.e("[Socket] Error, get null value.");
//       return;
//     }
//     if (!_response!.startsWith("a55a700290000001") ||
//         !_response!.endsWith("01015aa5")) {
//       LogUtil.e("[Socket] Error format.");
//       return;
//     }
//     LogUtil.v("[Socket] Processing on $_response.");
//     String jsonString = _response!.substring(16, _response!.length - 8);
//     LogUtil.v('[Socket] ' + jsonString);
//     var jsonMap = jsonDecode(jsonString);
//     // LogUtil.v(jsonMap['smajor']);
//     Student user = Student.fromJson(jsonMap);
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString("sname", user.ssgrade);
//     prefs.setString("smajor", user.smajor);
//     prefs.setString("sdepartment", user.sdepartment);
//     prefs.setString("sclass", user.sclass);
//     prefs.setString("ssgrade", user.ssgrade);
//     LogUtil.v("[SharedPreference] Student info saved.");
//   }
//   // static Future<void> loginCommunicate(String university,String studentID,String password)async{
//   //   var socket = await Socket.connect(IP_TEST, PORT_TEST).timeout(Duration(seconds: 1));
//   //   LoginPackage data = LoginPackage(university, studentID, password);
//   //   socket.write("a55a7001".toString() + data.toJson().toString() + "01015aa5".toString());
//   //   // await socket.flush();
//   //   LogUtil.v("[Login] Sent.");
//   //   try {
//   //     String _response='';
//   //     await socket.fold('', (previous, element){
//   //       _response=Utf8Decoder().convert(element);
//   //       LogUtil.v('[Login] Response: '+_response);
//   //     });
//   //     // socket.listen((event) {
//   //     //   while (_response.isEmpty) {
//   //     //     _response = Utf8Decoder().convert(event);
//   //     //     // LogUtil.v("222222222222222222222222222222222222222222222");
//   //     //     LogUtil.v("[Login] Response: " + _response);
//   //     //   }
//   //     // });
//   //     // LogUtil.v(_response);
//   //     if (_response.isEmpty){
//   //       LogUtil.v("[Socket] Error, get null value.");
//   //       return;
//   //     }
//   //     if(!_response.startsWith("a55a700290000001") || !_response.endsWith("01015aa5")){
//   //       LogUtil.v("[Socket] Error format.");
//   //       return;
//   //     }
//   //     String jsonString = _response.substring(11,_response.length-8);
//   //     LogUtil.v('[Socket] '+jsonString);
//   //     var s2 = await jsonDecode(_response);
//   //     Student user = Student.fromJson(s2);
//   //     final prefs = await SharedPreferences.getInstance();
//   //     prefs.setString("sname", user.ssgrade);
//   //     prefs.setString("smajor", user.smajor);
//   //     prefs.setString("sdepartment", user.sdepartment);
//   //     prefs.setString("sclass", user.sclass);
//   //     prefs.setString("ssgrade", user.ssgrade);
//   //     LogUtil.v("[SP] Student info saved.");
//   //     return;
//   //   }catch(e){
//   //     LogUtil.v(e);
//   //     return ;
//   //   }
//   //   finally{
//   //     socket.close();
//   //   }
//   // }
//
//   // static void loginSetSharedPreferences(String university,String studentID,String password)async{
//   //   LogUtil.v("[Socket] Info getting...");
//   //   await loginCommunicate(university, studentID, password);
//   //   LogUtil.v("333333333333333333333333333333333333");
//   //
//   // }
//
//   static receivePackageFromServer(
//       String ip, int port, int method, String data) {
//     Socket.connect(ip, port).then((socket) {
//       ServerSocket.bind(ip, port).then((serverSocket) {
//         serverSocket.listen((socket) {
//           socket.listen(print);
//         });
//       });
//     });
//   }
// }
