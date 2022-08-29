import 'package:flutter/material.dart';
import 'package:uni_campus/widgets/BodyProvider.dart';
import 'package:uni_campus/widgets/imageButton.dart';

class RootRoute extends StatefulWidget {
  @override
  _RootRouteState createState() => _RootRouteState();
}

class _RootRouteState extends State<RootRoute> {
  int _index = 0;

  void setIndex(int newIndex) {
    setState(() {
      if (newIndex != _index) _index = newIndex;
    });
  }

  final TextStyle _activeTextStyle =
      TextStyle(color: Color(0xFF253569), fontSize: 13);
  final TextStyle _inactiveTextStyle =
      TextStyle(color: Colors.grey, fontSize: 13);

  Image buttonImageProvider(AssetImage img) {
    return Image(
      image: img,
      height: 30,
      width: MediaQuery.of(context).size.width / 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    // _dateCheck();
    return Scaffold(
      body: BodyProvider(
        index: _index,
        indexChanged: setIndex,
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5,
              ), // margin above the navigator
              // bottom navigator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ExpandedImageButton(
                    key: UniqueKey(),
                    normalImage: _index == 0
                        ? buttonImageProvider(
                            AssetImage("images/BottomNavigate/HomeActive.png"))
                        : buttonImageProvider(
                            AssetImage("images/BottomNavigate/Home.png")),
                    pressedImage: buttonImageProvider(
                        AssetImage("images/BottomNavigate/HomeActive.png")),
                    normalStyle:
                        _index == 0 ? _activeTextStyle : _inactiveTextStyle,
                    pressedStyle: _activeTextStyle,
                    // width: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(color: Colors.white),
                    title: "Home",
                    onPressed: () {
                      setIndex(0);
                    },
                  ),
                  ExpandedImageButton(
                    key: UniqueKey(),
                    normalImage: _index == 4
                        ? buttonImageProvider(AssetImage(
                            "images/BottomNavigate/GroundActive.png"))
                        : buttonImageProvider(
                            AssetImage("images/BottomNavigate/Ground.png")),
                    pressedImage: buttonImageProvider(
                        AssetImage("images/BottomNavigate/GroundActive.png")),
                    normalStyle:
                        _index == 1 ? _activeTextStyle : _inactiveTextStyle,
                    pressedStyle: _activeTextStyle,
                    // width: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(color: Colors.white),
                    title: "Info",
                    onPressed: () {
                      setIndex(4);
                    },
                  ),
                  ExpandedImageButton(
                    key: UniqueKey(),
                    normalImage: _index == 1
                        ? buttonImageProvider(
                            AssetImage("images/BottomNavigate/NewsActive.png"))
                        : buttonImageProvider(
                            AssetImage("images/BottomNavigate/News.png")),
                    pressedImage: buttonImageProvider(
                        AssetImage("images/BottomNavigate/NewsActive.png")),
                    normalStyle:
                        _index == 1 ? _activeTextStyle : _inactiveTextStyle,
                    pressedStyle: _activeTextStyle,
                    // width: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(color: Colors.white),
                    title: "News",
                    onPressed: () {
                      setIndex(1);
                    },
                  ),
                  ExpandedImageButton(
                    key: UniqueKey(),
                    normalImage: _index == 2
                        ? buttonImageProvider(AssetImage(
                            "images/BottomNavigate/MessagesActive.png"))
                        : buttonImageProvider(
                            AssetImage("images/BottomNavigate/Messages.png")),
                    pressedImage: buttonImageProvider(
                        AssetImage("images/BottomNavigate/MessagesActive.png")),
                    normalStyle:
                        _index == 2 ? _activeTextStyle : _inactiveTextStyle,
                    pressedStyle: _activeTextStyle,
                    // width: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(color: Colors.white),
                    title: "Message",
                    onPressed: () {
                      setIndex(2);
                    },
                  ),
                  ExpandedImageButton(
                    key: UniqueKey(),
                    normalImage: _index == 3
                        ? buttonImageProvider(
                            AssetImage("images/BottomNavigate/MyActive.png"))
                        : buttonImageProvider(
                            AssetImage("images/BottomNavigate/My.png")),
                    pressedImage: buttonImageProvider(
                        AssetImage("images/BottomNavigate/MyActive.png")),
                    normalStyle:
                        _index == 3 ? _activeTextStyle : _inactiveTextStyle,
                    pressedStyle: _activeTextStyle,
                    // width: MediaQuery.of(context).size.width / 5,
                    decoration: BoxDecoration(color: Colors.white),
                    title: "My",
                    onPressed: () {
                      setIndex(3);
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }

// firstTimeLaunchDialog(BuildContext context){
//   showDialog(
//     context: context,
//     builder: (context) => mDialog(
//       "是否导入课表？",
//       Column(
//         children: [
//           Text("目前本应用还无法直接获取课表。\n需要您登陆教务处页面，并在课表页面点击「获取课表」以完成导入。\n若选择稍后导入，您可以在周视图右上角找到课表获取按钮，大概长下面这样。\n最后祝您，学业有成ww"),
//           Icon(Icons.download_rounded),
//         ],
//       ),
//       [
//         TextButton(
//             child: Text("现在导入"),
//           onPressed: ()=>Navigator.of(context).pushNamed(Routes.universityWeb).then((value)async{
//             await Future.delayed(Duration(milliseconds: 100));
//             LogUtil.v('[DEBUG] update!');
//             setState(() {weekIndex=-1;});
//             LogUtil.v('[DEBUG] switch!');
//             setState(() {weekIndex=DateCalculator.weekIndex;});
//           }
//           ),
//         ),
//         TextButton(
//             onPressed: (){
//               Navigator.of(context).pop();
//             },
//             child: Text("稍后导入")
//         )
//       ],
//     ),
//   );
// }

}
