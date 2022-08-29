import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uni_campus/Resource/colorList.dart';
import 'package:uni_campus/models/course.dart';
import 'package:uni_campus/models/database/classCommonOperate.dart';

/// 课表小块块，如果有冲突也是这里解决

class ClassCube extends StatefulWidget {
  ClassCube(
      this.className,
      this.classLocation,
      this.width,
      this.startIndex,
      this.endIndex,
      this.day,
      this.startWeek,
      this.endWeek,
      this.colorIndex,
      this.isConflict,
      this.className2,
      this.classLocation2,
      this.startIndex2,
      this.endIndex2,
      );

  // ClassCube.conflict(this.className, this.classLocation, this.width, this.colorIndex, this.startIndex, this.endIndex, this.day, this.startWeek, this.endWeek, this.isConflict, this.className2, this.classLocation2, );

  final String className;
  final String classLocation;
  final double width;
  final int colorIndex;
  final int startIndex;
  final int endIndex;
  final int day;
  final int startWeek;
  final int endWeek;
  final bool isConflict;
  final String className2;
  final String classLocation2;
  final int startIndex2;
  final int endIndex2;

  @override
  State<StatefulWidget> createState() => _classCube();
}

class _classCube extends State<ClassCube> {
  final ClassCommonOperate db = ClassCommonOperate();
  final TextEditingController _classNameController = TextEditingController();
  final TextEditingController _classLocationController =
      TextEditingController();
  final TextEditingController _classStartIndexController =
      TextEditingController();
  final TextEditingController _classEndIndexController =
      TextEditingController();
  // final TextEditingController _classStartWeekController =
  //     TextEditingController();
  // final TextEditingController _classEndWeekController = TextEditingController();

  bool disposed = false;
  bool conflictSwitch = false;
  late List<bool> weekList;

  init() {
    _classNameController.text = widget.className;
    _classNameController.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream, offset: widget.className.length));
    _classLocationController.text = widget.classLocation;
    _classStartIndexController.text = widget.startIndex==0 ?"":widget.startIndex.toString();
    _classEndIndexController.text = widget.endIndex==0 ?"":widget.endIndex.toString();
    // _classStartWeekController.text = widget.startWeek.toString();
    // _classEndWeekController.text = widget.endWeek.toString();
  }

  @override
  Widget build(BuildContext context) {
    // LogUtil.v('[debug] ${widget.width} ${(50.0 * (widget.endIndex - widget.startIndex + 1) + 4 * (widget.endIndex - widget.startIndex))}');
    return GestureDetector(
        onTap: widget.isConflict ? _stateSwitch : _alertSimpleDialog,
        child: Container( /// 选择最大的高度
            height: widget.isConflict
                ? (widget.endIndex - widget.startIndex >
                widget.endIndex2 - widget.startIndex2)
                ? (50.0 * (widget.endIndex - widget.startIndex + 1) +
                4 * (widget.endIndex - widget.startIndex))
                : (50.0 * (widget.endIndex2 - widget.startIndex2 + 1) +
                4 * (widget.endIndex2 - widget.startIndex2))
                : (50.0 * (widget.endIndex - widget.startIndex + 1) +
                4 * (widget.endIndex - widget.startIndex)),
            // (50.0*(widget.endIndex2-widget.startIndex2+1)+4*(widget.endIndex2-widget.startIndex2)):
            width: widget.width,
            margin: EdgeInsets.all(2),
            padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
            decoration: BoxDecoration(
              color: colorList[widget.colorIndex],
              borderRadius: new BorderRadius.circular(3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.isConflict
                      ? '[冲突]' +
                      (conflictSwitch ? widget.className : widget.className2)
                      : widget.className,
                  style: _classesNameStyle,
                  maxLines: 4,
                ),
                widget.isConflict
                    ? Text(
                  conflictSwitch
                      ? "${widget.startIndex}-${widget.endIndex}节"
                      : "${widget.startIndex2}-${widget.endIndex2}节",
                  style: _classesNameStyle,
                  maxLines: 4,
                )
                    : SizedBox(),
                Text(
                  widget.isConflict
                      ? (conflictSwitch
                      ? widget.classLocation
                      : widget.classLocation2)
                      : widget.classLocation,
                  style: _classesLocationStyle,
                  maxLines: 2,
                ),
              ],
            ),
          ));
  }

  // List<Widget> _disposedWidgetBuilder(int len){
  //   List<Widget> result=[];
  //   for(int i=0; i<len;i++){
  //     result.add(
  //       Container(
  //         height: 50,
  //         width: widget.width,
  //         margin: EdgeInsets.all(2),
  //         padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
  //         decoration: BoxDecoration(
  //           color: colorList[0],
  //           borderRadius: new BorderRadius.circular(3),
  //         ),
  //       )
  //     );
  //   }
  //   return result;
  // }

  /// if conflict, tap cube will switch between two courses
  _stateSwitch() {
    conflictSwitch = !conflictSwitch;
    setState(() {});
  }

  /// show modify dialog, continues week
  ///    return Dialog
  _alertSimpleDialog() async {
    init();
    // bool _zero = true;
    if (widget.className == '') {
      weekList = [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
      ];
    } else {
      weekList = await db.selectCourseWeek(
          widget.className, widget.day, widget.startIndex, widget.endIndex);
    }
    for (int i = widget.startWeek; i < widget.endWeek + 1; i++) {
      weekList[i] = true;
    }
    /// 修改课程用的对话框
    var alertDialogs = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Text("修改课程信息",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height:30,
                        child: TextField(
                          autofocus: true,
                          decoration:
                          InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical:8.0),
                            hintText: ("课程名称"),
                          ),
                          controller: _classNameController,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Divider(),
                      Container(
                        height:30,
                        // width: double.infinity,
                        child: TextField(
                          decoration:
                          InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                            hintText: ("课程地点"),
                            // alignLabelWithHint:true,
                            // border: OutlineInputBorder(),
                          ),
                          // autofocus: true,
                          controller:_classLocationController,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Divider(),
                      Container(
                        height:30,
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("第 "),
                            Container(
                              height:20,
                              width: 50,
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration:
                                InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: -25.0),
                                  hintText: ("节数"),
                                ),
                                controller: _classStartIndexController,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Text("小节 到 第 "),
                            Container(
                              height:20,
                              width: 50,
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration:
                                InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: -25.0),
                                  hintText: ("节数"),
                                ),
                                controller: _classEndIndexController,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Text("小节"),
                          ],
                        ),
                      ),
                      Divider(),
                      Center(
                        child: Text("周 数",style: TextStyle(
                          fontSize: 20,
                        ),),
                      ),
                      SizedBox(height: 5),
                      weekButtonBuilder(1, 10, setState),
                      weekButtonBuilder(10, 19, setState),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              db.deleteCourse(widget.className, widget.day,
                                  widget.startIndex, widget.endIndex);
                              // widget.disposed = true;
                              Navigator.of(context).pop();
                              Fluttertoast.showToast(
                                  msg: "删除成功",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  // backgroundColor: Colors.blue,
                                  // textColor: Colors.blueGrey,
                                  fontSize: 16.0);
                               // initState();
                            },
                            child: Text('删除'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              LogUtil.v("[${_classStartIndexController.text}], [${_classEndIndexController.text}]");
                              if (!(int.parse(_classEndIndexController.text) >
                                          5 &&
                                      int.parse(
                                              _classStartIndexController.text) <
                                          6) &&
                                  !(int.parse(_classEndIndexController.text) >
                                          10 &&
                                      int.parse(
                                              _classStartIndexController.text) <
                                          11)) {
                                if (widget.className != '') {
                                  await db.deleteCourse(
                                      widget.className,
                                      widget.day,
                                      widget.startIndex,
                                      widget.endIndex);
                                }
                                LogUtil.v("[debug] ${weekList.toString()}");
                                List<Course> courseList = [];
                                for (int i = 1; i < 19; i++) {
                                  if (weekList[i]) {
                                    LogUtil.v("[debug] index: $i ");
                                    var tmp = Course(
                                        _classNameController.text,
                                        widget.day,
                                        i,
                                        i,
                                        int.parse(
                                            _classStartIndexController.text),
                                        int.parse(
                                            _classEndIndexController.text),
                                        _classLocationController.text,
                                        '');
                                    LogUtil.v(
                                        "[debug] add $i, ${tmp.toJson()}");
                                    courseList.add(Course(
                                        _classNameController.text,
                                        widget.day,
                                        i,
                                        i,
                                        int.parse(
                                            _classStartIndexController.text),
                                        int.parse(
                                            _classEndIndexController.text),
                                        _classLocationController.text,
                                        ''));
                                  }
                                }
                                db.insertCourses(courseList);
                                Fluttertoast.showToast(
                                    msg: "更新成功",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    // backgroundColor: Colors.blue,
                                    // textColor: Colors.blueGrey,
                                    fontSize: 16.0);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "课程小节数不支持跨越休息时间",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    // backgroundColor: Colors.blue,
                                    // textColor: Colors.blueGrey,
                                    fontSize: 16.0);
                              }
                              Navigator.of(context).pop();
                            },
                            child: Text('更新'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
    return alertDialogs;
  }

  Widget weekButtonBuilder(int start, int end, var setState) {
    List<Widget> ls = [];
    for (int i = start; i < end; i++) {
      ls.add(
        GestureDetector(
            onTap: () {
              // LogUtil.v("[Debug] click on index: $i");
              setState(() {
                weekList[i] = !weekList[i];
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6 / 9,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(5.0),
                color: weekList[i] ? Colors.deepOrangeAccent : Colors.white,
              ),
              child: Center(
                child: Text(" $i ", style: _weekTextStyle),
              ),
            )),
      );
      ls.add(SizedBox(
        width: 2,
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: ls,
    );
  }

  /// styles
  final TextStyle _classesNameStyle = TextStyle(
    letterSpacing: 0,
    wordSpacing: 0,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Colors.white,
    overflow: TextOverflow.ellipsis,
  );
  final TextStyle _classesLocationStyle = TextStyle(
    letterSpacing: 0,
    wordSpacing: 0,
    fontSize: 12,
    color: Colors.white,
    overflow: TextOverflow.ellipsis,
  );
  final TextStyle _weekTextStyle = TextStyle(
    fontSize: 15,
    // color: Colors.blueAccent,
  );
}
