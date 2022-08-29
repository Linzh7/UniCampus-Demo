import 'package:flutter/material.dart';
import 'package:uni_campus/models/message.dart';

import 'package:uni_campus/widgets/imageButton.dart';

Image _buttonImageProvider(BuildContext context, AssetImage img, double width) {
  return Image(
    image: img,
    width: width,
    height: 60,
  );
}

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 45),
        child: SafeArea(
          child: Container(
            // height: 100,
            decoration: BoxDecoration(
              //todo:将appbar设置透明，body设置背景图
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ExpandedImageButton(
                      key: UniqueKey(),
                      normalImage: _buttonImageProvider(
                          context,
                          AssetImage("images/MessagePage/like.png"),
                          80),
                      pressedImage: _buttonImageProvider(
                          context,
                          AssetImage("images/MessagePage/like.png"),
                          80),
                      title: "Like",
                      normalStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      pressedStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      // width: 80,
                      onPressed: null,
                    ),
                    ExpandedImageButton(
                      key: UniqueKey(),
                      normalImage: _buttonImageProvider(
                          context,
                          AssetImage("images/MessagePage/ok.png"),
                          80),
                      pressedImage: _buttonImageProvider(
                          context,
                          AssetImage("images/MessagePage/ok.png"),
                          80),
                      title: "@ me",
                      normalStyle: TextStyle(
                        fontSize: 18,
                        // fontFamily: "YouSheBiaoTiHei",
                        fontWeight: FontWeight.w500,
                      ),
                      pressedStyle: TextStyle(
                        fontSize: 18,
                        // fontFamily: "YouSheBiaoTiHei",
                        fontWeight: FontWeight.w500,
                      ),
                      // width: 80,
                      onPressed: null,
                    ),
                    ExpandedImageButton(
                      key: UniqueKey(),
                      normalImage: _buttonImageProvider(
                          context,
                          AssetImage("images/MessagePage/friends.png"),
                          80),
                      pressedImage: _buttonImageProvider(
                          context,
                          AssetImage("images/MessagePage/friends.png"),
                          80),
                      title: "New friends",
                      normalStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      pressedStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      // width: 80,f
                      onPressed: null,
                    ),
                  ],
                ),
              ),
            ]
            )
          )
        )
      ),
      body: Container(
        child: ListView.builder(
          itemCount: demoMessageData.length,
          itemBuilder: (context, i) => Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.95,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.transparent,
                        // child:Text(' '),
                        //   backgroundImage:AssetImage(
                        // "images/NewsPage/TestUserAvatar.png",
                        //   ),
                        child: Image.asset(
                            "images/NewsPage/Icon.png",
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Test",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "01234567890",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "01/28",
                            style:
                                TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ClipOval(
                              child: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                            ),
                              child: Center(
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            )
                          ),
                        ],
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
