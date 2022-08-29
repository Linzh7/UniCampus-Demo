import 'package:flutter/material.dart';
import 'package:uni_campus/routes/pages/MyPage.dart';
import 'package:uni_campus/routes/pages/HomePage.dart';
import 'package:uni_campus/routes/pages/NewsPage.dart';
import 'package:uni_campus/routes/pages/MessagePage.dart';
import 'package:uni_campus/routes/pages/SquarePage.dart';

class BodyProvider extends StatelessWidget {
  BodyProvider({Key? key, required this.index, required this.indexChanged})
      : super(key: key);

  final int index;
  final ValueChanged<int> indexChanged;

  @override
  Widget build(BuildContext context) {
    if (index == 0)
      return HomePage();
    else if (index == 1)
      return NewsPage();
    else if (index == 2)
      return MessagePage();
    else if (index == 3)
      return MyPage();
    else if (index == 4)
      return SquarePage();
    else
      return HomePage();
  }
}
