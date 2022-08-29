import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_campus/widgets/infoCard.dart';

class NewsPage extends StatefulWidget {
  // final InAppBrowser browser = new InAppBrowser();

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _textFieldController = TextEditingController();

  SelectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, //todo:2021.9.22 图标和文字之间间距无法调整
          children: <Widget>[
            Icon(
              icon,
              color: Color(0xFFFF4907),
              size: 25,
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFFFF4907),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    // var options = InAppBrowserClassOptions(
    //   crossPlatform: InAppBrowserOptions(hideUrlBar: false),
    //   inAppWebViewGroupOptions: InAppWebViewGroupOptions(
    //   crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              toolbarHeight: MediaQuery.of(context).padding.top + 25,
              leading: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: ClipOval(
                    child: Image.asset("images/NewsPage/Icon.png",
                        height: 40, width: 40, fit: BoxFit.cover),
                  ),
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {}),
              actions: <Widget>[
                PopupMenuButton<String>(
                  tooltip: "打开菜单", //todo:2021.9.22 无法取消长按唤起亦或是调整唤起框的decoration
                  icon: Icon(
                    Icons.tune,
                    color: Colors.white,
                  ),
                  iconSize: 35,
                  color: Color(0xFFFADBCE),
                  offset: Offset(-5, 57),
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuItem<String>>[
                    this.SelectView(Icons.home, 'Homepage', 'A'),
                    this.SelectView(Icons.favorite, 'Favorite', 'B'),
                  ],
                  onSelected: (String action) {
                    // 点击选项的时候
                    switch (action) {
                      case 'A':
                        {
                          launch("https://linzh.me");
                          break;
                        }
                      case 'B':
                        {
                          launch(
                              "https://poem.linzh.me");
                          break;
                        }
                    }
                  },
                ),
              ],
              title: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _textFieldController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 0.0),
                              hintText: 'Search for',
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      color: Colors.grey,
                      iconSize: 22.0,
                      onPressed: () {
                        launch(
                            "https://www.baidu.com/s?wd=${_textFieldController.text}");
                        _textFieldController.clear();
                        // onSearchTextChanged('');
                      },
                    ),
                  ],
                ),
              ),
              // bottom: TabBar(
              //   indicatorSize: TabBarIndicatorSize.label,
              //   indicatorWeight: 3.0,
              //   isScrollable: true,
              //   unselectedLabelColor: Colors.grey,
              //   unselectedLabelStyle: unselectedTabStyle,
              //   labelColor: Colors.black,
              //   labelStyle: selectedTabStyle,
              //   tabs: <Widget>[
              //     Text("A"),
              //     Text("B"),
              //     Text("C"),
              //     Text("D"),
              //   ],
              // ),
              flexibleSpace: SafeArea(
                child: Container(
                  // height: 100,//_getSize(context, 1, 225),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFFBF93), Color(0xFFFF4300)],
                    ),
                  ),
                ),
              )),
          body: Container(
            color: Color(0xFFF5F5F5),
            child:
            TabBarView(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    InfoCard(
                        "hello",
                        'from here',
                        Image.asset(
                          "images/NewsPage/img1.jpg",
                          fit: BoxFit.fitWidth,
                        ),
                        'Github Main Page',
                        "https://github.com/Linzh7",
                        "Describe"),
                    InfoCard(
                        "moi",
                        'from another place',
                        Image.asset(
                          "images/NewsPage/img2.jpg",
                          fit: BoxFit.fitWidth,
                        ),
                        'Github Repositories Page',
                        "https://github.com/Linzh7?tab=repositories",
                        "Another describe"),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  _showCommentDialog() {
    TextEditingController _name = TextEditingController();
    TextEditingController _contact = TextEditingController();
    TextEditingController _comment = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
              title: Center(
                child: Text("Feedback"),
              ),
              children: [
                Container(
                  // margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _name,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Name',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _contact,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.contact_mail),
                          hintText: 'e-mail',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _comment,
                        minLines: 1,
                        maxLines: 10,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.create),
                          hintText: 'Your comments or suggestions.',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_name.text.isEmpty && _comment.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Name and comments cannot be null",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                          } else {
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            Sentry.captureUserFeedback(SentryUserFeedback(
                              eventId: await Sentry.captureMessage((sp
                                          .getString("Name") ??
                                      'Unknown User') +
                                  ' Issue Report ${DateTime.now().toIso8601String()}'),
                              comments: _comment.text,
                              email: _contact.text,
                              name: _name.text,
                            ));
                            Fluttertoast.showToast(
                                msg: "Success!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text("Send!"),
                      ),
                    ],
                  ),
                )
              ]);
        });
  }
}
