import 'package:flutter/material.dart';
import 'package:uni_campus/resource/colorList.dart';
import 'package:uni_campus/resource/classIndexMap.dart';


/// 主页面的那个横的长条

class ClassCard extends StatelessWidget {
  ClassCard(
      this.className,
      this.classLocation,
      this.day,
      this.startIndex,
      this.endIndex,
      this.startWeek,
      this.endWeek,
      this.teacher,
      this.colorIndex);

  final String className;
  final String classLocation;
  final String teacher;
  final int startIndex;
  final int endIndex;
  final int startWeek;
  final int endWeek;
  final int colorIndex;
  final int day;

  final TextStyle _courseTimeStyle =
      TextStyle(fontSize: 40, color: Colors.black, fontWeight: FontWeight.w500);
  final TextStyle _courseInfoStyle =
      TextStyle(fontSize: 15, color: Colors.grey);
  final TextStyle _courseNameStyle =
      TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600);

  // final List<Color> _colorList = [
  //   // Colors.grey,
  //   Colors.blue,
  //   Color(0xFFFF8D8E),
  //   Colors.green,
  //   Colors.orange,
  //   Colors.cyan,
  // ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, Routes.sign,
        //     arguments: Course(className, day, 0, 0, startIndex, endIndex, classLocation, teacher)
        // );
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  // width=20
                  height: 50,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border: Border.all(
                        color: colorList[colorIndex],
                        width: 4,
                      ))),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    startIndex2TimeMap[startIndex]!,
                    style: _courseTimeStyle,
                  ),
                  Text(
                    "$startIndex-$endIndex节 | ${endIndex2TimeMap[endIndex]} 下课",
                    style: _courseInfoStyle,
                  ),
                ],
              ),
              // Spacer(),
              Expanded(
                // width: MediaQuery.of(context).size.width * 0.9-165,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Row(
                    //   children: [
                    //     // a dot
                    //     Container(
                    //         margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    //             border: Border.all(
                    //               color: _colorList[colorIndex],
                    //               width: 4,
                    //             )
                    //         )
                    //     ),
                    //     Text("sign",style: _courseInfoStyle,)
                    //   ],
                    // ),
                    Text(className,
                        textAlign: TextAlign.right,
                        style: _courseNameStyle,
                        softWrap: true),
                    Text(
                      "$classLocation",
                      style: _courseInfoStyle,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )),
    );
  }
}
