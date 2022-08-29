import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:uni_campus/routes/commonResource.dart';
import 'package:uni_campus/widgets/infoCard.dart';

class HelpRoute extends StatefulWidget {
  @override
  _HelpRouteState createState() => _HelpRouteState();
}

class _HelpRouteState extends State<HelpRoute> {
  Color _mainColor = Color(0xFF640EE6);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            centerTitle: true,
            elevation: 0,
            backgroundColor: _mainColor,
            title: Text(
              "A",
              style: TextStyle(
                fontSize: 20,
                //fontFamily: "Microsoft_YaHei",
                color: Color.fromRGBO(255, 255, 255, 0.9),
              ),
            ),
            // flexibleSpace: Text("123"),
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 20),
              child: Container(
                width: double.infinity,
                // padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.white, width: 0.0)),
                  color: _mainColor,
                ),
                child: Container(
                  width: double.infinity,
                  height: 35,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      )),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3.0,
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    unselectedLabelStyle: unselectedTabStyle,
                    labelColor: Colors.black,
                    indicatorColor: Colors.pinkAccent.shade100,
                    labelStyle: selectedTabStyle,
                    tabs: <Widget>[
                      Text("A"),
                      Text("B"),
                      Text("C"),
                      Text("D"),
                      // Text(" "),
                      // Text(" "),
                      // Text(" "),
                      // Text(" "),
                      // Text(" "),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  InfoCard(
                      "Text",
                      '',
                      Image.asset(
                        "images/HomePage/img1.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                      'Text',
                      "https://linzh.me",
                      "Text"),
                  ImageInfoCard(
                      "Image Info card",
                      '',
                      Image.asset(
                        "images/SquarePage/img4.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                      'Image Info card',
                      "https://linzh.me",
                      "click different place.",
                      AssetImage("images/SquarePage/img4.jpg")),
                ],
              ),
              ListView(
                children: <Widget>[
                  InfoCard(
                      "Text",
                      '',
                      Image.asset(
                        "images/HomePage/img1.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                      'Text',
                      "https://linzh.me",
                      "Text"),
                ],
              ),
              ListView(
                children: <Widget>[
                  InfoCard(
                      "Text",
                      '',
                      Image.asset(
                        "images/HomePage/img1.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                      'Text',
                      "https://linzh.me",
                      "Text"),
                ],
              ),
              ListView(
                children: <Widget>[
                  InfoCard(
                      "Text",
                      '',
                      Image.asset(
                        "images/HomePage/img2.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                      'Text',
                      "https://linzh.me",
                      "Text"),
                ],
              ),
            ],
          ),
        ));
  }
}
