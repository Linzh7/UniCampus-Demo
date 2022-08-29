import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uni_campus/resource/urls.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_campus/models/course.dart';
import 'package:uni_campus/models/database/classCommonOperate.dart';
import 'package:uni_campus/utils/webUtil.dart';
import 'package:uni_campus/widgets/dialog.dart';

class UniversityWebRoute extends StatefulWidget {
  final int graduate;

  UniversityWebRoute(this.graduate);

  @override
  State<StatefulWidget> createState() => _universityWebRouteState();
}

class _universityWebRouteState extends State<UniversityWebRoute> {
  InAppWebViewController? _controller;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));
  double progress = 0;
  ClassCommonOperate db = ClassCommonOperate();

  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }
    db.open();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text("课程导入"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                      url: Uri.parse(widget.graduate == 0
                          ? UNDERGRADUATE_URL
                          : POSTGRADUATE_URL)),
                  initialOptions: options,
                  onWebViewCreated: (controller) {
                    _controller = controller;
                  },
                  androidOnPermissionRequest:
                      (controller, origin, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  onJsAlert: (controller, jsAlertRequest) async {
                    LogUtil.v('[Debug] Clicked!');
                    showDialog(
                      context: context,
                      builder: (context) => mDialog(
                        "验证码已发送",
                        Text("请检查消息，预计在30s-180s内收到。"),
                        [
                          TextButton(
                            child: Text("知道了"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                    return JsAlertResponse(
                        handledByClient: true,
                        action: JsAlertResponseAction.CONFIRM);
                  },
                  onJsConfirm: (controller, jsConfirmRequest) async {
                    return JsConfirmResponse(
                        handledByClient: true,
                        action: JsConfirmResponseAction.CONFIRM);
                  },
                  onJsPrompt: (controller, jsPromptRequest) async {
                    return JsPromptResponse(
                        handledByClient: true,
                        action: JsPromptResponseAction.CONFIRM,
                        value: 'new value');
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;
                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunch(UNDERGRADUATE_URL)) {
                        await launch(
                          UNDERGRADUATE_URL,
                        );
                        return NavigationActionPolicy.CANCEL;
                      }
                    }
                    return NavigationActionPolicy.ALLOW;
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment(0, 0.9),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              child: Text(
                "导入课表",
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () async {
                try {
                  var tmp;
                  if(widget.graduate == 0){
                    tmp = await WebUtil.getCoursesListFromHTML(await _controller?.getHtml() ?? '');
                  }else{
                    tmp = await WebUtil.getPostgraduateCoursesListFromHTML(await _controller?.getHtml() ?? '');
                  }
                  var courseList = tmp[0];
                  String error = tmp[1];

                  LogUtil.v('[debug] course1: ${courseList[0].toJson()}');
                  if(error.isNotEmpty){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("导入中出现了错误，已导入无差错的部分。\n错误内容如下：${error}"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text("我已知悉"),
                            )
                          ],
                        );
                      },
                    );
                  }else{
                    if (courseList.isNotEmpty) {
                      await db.removeAll();
                      db.insertCourses(courseList);
                      LogUtil.v("[CourseTable] done.");
                      Fluttertoast.showToast(
                          msg: "课表已更新",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          // backgroundColor: Colors.redAccent,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pop(context, false);
                    }
                  }
                } catch (e) {
                  LogUtil.e("[WebTable] Error: $e");
                  Fluttertoast.showToast(
                      msg: "无法定位课表",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.redAccent,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
            // FloatingActionButton(
            //   onPressed: () async {
            //     try {
            //       List<Course> courseList =
            //       await WebUtil.getCoursesListFromHTML(
            //           await _controller?.getHtml() ?? '');
            //       LogUtil.v('[debug] course1: ${courseList[0].toJson()}');
            //       if (courseList.isNotEmpty) {
            //         await db.removeAll();
            //         db.insertCourses(courseList);
            //         LogUtil.v("[CourseTable] done.");
            //         Fluttertoast.showToast(
            //             msg: "课表已更新",
            //             toastLength: Toast.LENGTH_SHORT,
            //             gravity: ToastGravity.CENTER,
            //             timeInSecForIosWeb: 1,
            //             // backgroundColor: Colors.redAccent,
            //             textColor: Colors.white,
            //             fontSize: 16.0);
            //         Navigator.pop(context, false);
            //       }
            //     } catch (e) {
            //       LogUtil.e("[WebTable] Error:$e");
            //       Fluttertoast.showToast(
            //           msg: "无法定位课表",
            //           toastLength: Toast.LENGTH_SHORT,
            //           gravity: ToastGravity.CENTER,
            //           timeInSecForIosWeb: 1,
            //           backgroundColor: Colors.redAccent,
            //           textColor: Colors.white,
            //           fontSize: 16.0);
            //     }
            //   },
            //   child: Icon(Icons.download_rounded,size: 40,),
            //   foregroundColor: Colors.white,
            //   backgroundColor: Colors.deepOrangeAccent,
            //   shape: CircleBorder(),
            // ),
          ),
        ],
      ),
    );
  }
}

