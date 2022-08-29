import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_campus/models/database/classCommonOperate.dart';

/// 图书馆馆藏查询web界面


class LibraryInquiry extends StatefulWidget {
  final String book;
  LibraryInquiry(this.book);
  @override
  State<StatefulWidget> createState() => _libraryInquiry();
}

class _libraryInquiry extends State<LibraryInquiry> {
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
          title: Text("Search in library"),
        ),
        body: Container(
          child: InAppWebView(
            initialUrlRequest: URLRequest(
                url: Uri.parse(
                    "https://helka.helsinki.fi/discovery/search?vid=358UOH_INST:VU1&lang=en&query=any,contains,${widget.book}")),
            initialOptions: options,
            // onWebViewCreated: (controller) {
            //   _controller = controller;
            // },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
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
                if (await canLaunch(
                    "https://helka.helsinki.fi/discovery/search?vid=358UOH_INST:VU1&lang=en&query=any,contains,${widget.book}")) {
                  await launch(
                    "https://helka.helsinki.fi/discovery/search?vid=358UOH_INST:VU1&lang=en&query=any,contains,${widget.book}",
                  );
                  return NavigationActionPolicy.CANCEL;
                }
              }
              return NavigationActionPolicy.ALLOW;
            },
          ),
        ));
  }
}
