import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_campus/routes/Routes.dart';
import 'dart:ui';
import 'package:uni_campus/widgets/blurWidget.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// ignore: must_be_immutable
class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  String versionString = "Version: 1.0.4, Build: 10074";

  // final TextStyle _simpleOptionTextStyle = TextStyle(fontSize: 20);
  // final TextStyle _simpleOptionTitleTextStyle = TextStyle(fontSize: 25);
  // final _textFieldController = TextEditingController();
  late double buttonWidth;

  String name = '';

  getName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = await sp.getString('Name') ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getName();
    buttonWidth = MediaQuery.of(context).size.width * 0.3;
    // LogUtil.v("[debug] squarePage name: ${Settings.name}");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: Image(
                      image: AssetImage("images/MyPage/background.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.05,
                    top: MediaQuery.of(context).size.height * 0.03,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 255, 128, 0.9),
                                // fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "Student",
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 255, 128, 0.9),
                                // fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              "Welcome!",
                              style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(255, 255, 128, 0.9),
                                // fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      )
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.08,
                    top: MediaQuery.of(context).size.height * 0.06,
                    child: BlurOvalWidget(
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                            border: new Border.all(
                                color: Colors.transparent, width: 0),
                            color: Colors.black,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "images/NewsPage/Icon.png",
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buttonFunction(
                        "images/MyPage/Feedback.png",
                        "Feedback",
                            () {
                          _showCommentDialog();
                        },
                      ),
                      buttonRouteLaunch(
                        "images/MyPage/Join.png",
                        "Contect",
                        Routes.yellowPages,
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buttonLaunch(
                        "images/MyPage/Academic.png",
                        "Homepage",
                        "https://linzh.me",
                      ),
                      buttonLaunch(
                        "images/MyPage/Illustrate.png",
                        "Article",
                        "https://article.linzh.me/",
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buttonLaunch(
                        "images/MyPage/Teaching.png",
                        "Tech",
                        "https://tech.linzh.me/",
                      ),
                      buttonLaunch(
                        "images/MyPage/Card.png",
                        "Poem",
                        "https://poem.linzh.me",
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Text(versionString, style: TextStyle(color: Colors.grey.shade300),),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonLaunch(String imagePath, String buttonText, String urlString) {
    return TextButton(
        onPressed: () => launch(urlString),
        style: ButtonStyle(
            // maximumSize: ,
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            side: MaterialStateProperty.all(
              BorderSide(color: Colors.transparent, width: 0),
            ),
            backgroundColor: MaterialStateProperty.all(Color(0xFFF0F8FF))),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // SizedBox(width: 10,),
              Image.asset(imagePath, height: 40, width: 40, fit: BoxFit.cover),
              // SizedBox(width: 00,),
              Text(
                buttonText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // SizedBox(width: 5,),
            ],
          ),
        ));
  }

  Widget buttonRouteLaunch(String imagePath, String buttonText, String urlString) {
    return TextButton(
        onPressed: () => Navigator.pushNamed(context, urlString),
        style: ButtonStyle(
          // maximumSize: ,
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            side: MaterialStateProperty.all(
              BorderSide(color: Colors.transparent, width: 0),
            ),
            backgroundColor: MaterialStateProperty.all(Color(0xFFF0F8FF))),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // SizedBox(width: 10,),
              Image.asset(imagePath, height: 40, width: 40, fit: BoxFit.cover),
              // SizedBox(width: 00,),
              Text(
                buttonText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // SizedBox(width: 5,),
            ],
          ),
        ));
  }

  Widget buttonFunction(
      String imagePath, String buttonText, void Function()? fnc) {
    return TextButton(
        onPressed: fnc,
        style: ButtonStyle(
            // maximumSize: ,
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            side: MaterialStateProperty.all(
              BorderSide(color: Colors.transparent, width: 0),
            ),
            backgroundColor: MaterialStateProperty.all(Color(0xFFF0F8FF))),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // SizedBox(width: 10,),
              Image.asset(imagePath, height: 40, width: 40, fit: BoxFit.cover),
              // SizedBox(width: 00,),
              Text(
                buttonText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // SizedBox(width: 5,),
            ],
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
                  margin: EdgeInsets.all(10),
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
                          hintText: 'E-mail',
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
                                msg: "Name and comments cannot be null.",
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
                                msg: "Success",
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
