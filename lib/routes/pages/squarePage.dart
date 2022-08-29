import 'package:flutter/material.dart';
import 'package:uni_campus/routes/Routes.dart';
import 'package:uni_campus/widgets/imageButton.dart';

import '../libraryQuiry.dart';

class SquarePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SquarePage();
}

class _SquarePage extends State<SquarePage> {
  final _textFieldController = TextEditingController();
  late double buttonWidth;

  // int freshCount = 0;
  // futureRefresh() async {
  //   if (Settings.name == ' ' && freshCount < 100) {
  //     await Future.delayed(Duration(milliseconds: 25));
  //     freshCount++;
  //     LogUtil.v('[Refresh] done.');
  //     setState(() {});
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.width<360) {
      buttonWidth = MediaQuery.of(context).size.width * 0.3;
      // print(MediaQuery.of(context).size.width);
    }else {
      buttonWidth = 104;
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                        AssetImage("images/SquarePage/img.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 15,
                          top: 30,
                          child: Text(
                            "Hello~",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 40,
                          top: 70,
                          child: Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 255, 255, 0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  left: 30,
                  top: 175,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(height: 15.0,),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                child: TextField(
                                  // cursorColor: Colors.black,
                                  cursorWidth: 2,
                                  cursorRadius: Radius.circular(30),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    textBaseline: TextBaseline.alphabetic,
                                    fontSize: 20,
                                  ),
                                  controller: _textFieldController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(0),
                                      hintText: 'Search on Helka',
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                      ),
                                      border: InputBorder.none),
                                  // onChanged: onSearchTextChanged,
                                ),
                              ),
                              new IconButton(
                                icon: new Icon(Icons.search),
                                color: Colors.grey,
                                iconSize: 30.0,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LibraryInquiry(
                                              _textFieldController.text)));
                                },
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(width: 15.0,),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 220,
                  left: 10,
                  right: 10,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ImageButton(
                              normalImage: Image.asset("images/SquarePage/MyUniversity.png",width: buttonWidth,),
                              pressedImage: Image.asset("images/SquarePage/MyUniversity.png",width: buttonWidth,),
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.squareMy),
                              title: '',
                              key: UniqueKey(),
                            ),
                            ImageButton(
                              normalImage: Image.asset("images/SquarePage/Help.png",width: buttonWidth,),
                              pressedImage: Image.asset("images/SquarePage/Help.png",width: buttonWidth,),
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.squareHelp),
                              title: '',
                              key: UniqueKey(),
                            ),
                            ImageButton(
                              normalImage: Image.asset("images/SquarePage/Create.png",width: buttonWidth,),
                              pressedImage: Image.asset("images/SquarePage/Create.png",width: buttonWidth,),
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes .squareCreate),
                              title: '',
                              key: UniqueKey(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ImageButton(
                              normalImage: Image.asset("images/SquarePage/Foods.png",width: buttonWidth,),
                              pressedImage: Image.asset("images/SquarePage/Foods.png",width: buttonWidth,),
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.squareFood),
                              title: '',
                              key: UniqueKey(),
                            ),
                            ImageButton(
                              normalImage: Image.asset("images/SquarePage/Study.png",width: buttonWidth,),
                              pressedImage: Image.asset("images/SquarePage/Study.png",width: buttonWidth,),
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.squareStudy),
                              title: '',
                              key: UniqueKey(),
                            ),
                            ImageButton(
                              normalImage: Image.asset("images/SquarePage/Moreover.png",width: buttonWidth,),
                              pressedImage: Image.asset("images/SquarePage/Moreover.png",width: buttonWidth,),
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.squareService),
                              title: '',
                              key: UniqueKey(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  }
