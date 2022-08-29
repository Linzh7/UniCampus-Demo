import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_campus/Resource/classIndexMap.dart';
import 'package:uni_campus/models/course.dart';
import 'package:uni_campus/models/database/classListGetter.dart';
import 'package:uni_campus/models/database/databaseHelper.dart';
import 'package:uni_campus/routes/universityWebRoute.dart';
import 'package:uni_campus/utils/dateCalculator.dart';
import 'package:uni_campus/utils/updateUtil.dart';
import 'package:uni_campus/widgets/dialog.dart';
import 'package:uni_campus/widgets/halfDayCoursesProvider.dart';
import 'package:uni_campus/widgets/classCardList.dart';
import 'package:uni_campus/common/settings.dart';
import 'package:uni_campus/widgets/imageButton.dart';
import 'package:uni_campus/widgets/webViewPage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  // 当前数
  int weekIndex = DateCalculator.weekIndex;
  // 下拉框选择的当前数
  var selectedItem;


  // 提供统一高度的按钮图片
  Image buttonImageProvider(AssetImage img) {
    // print(MediaQuery.of(context).size.height);
    double size=23;
    if(MediaQuery.of(context).size.height < 700){
      size = 15;
    }else if(MediaQuery.of(context).size.height < 750){
      size = 20;
    }
    return Image(
      image: img,
      height: size,
      width: size,
    );
  }

  // 数据库操作
  late DatabaseHelper dbHelper;

  // 五天与七天方案
  bool isFiveDayMode = Settings.daysPerWeek == 7 ? false: true;



  // 保存视图天数
  setSetting(int daysPerWeek) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LogUtil.v(
        "[Setting] DaysPerWeek 5-day mode is $isFiveDayMode, Setting: ${Settings.daysPerWeek}");
    prefs.setInt("DaysPerWeek", daysPerWeek);
  }

  List<Map> imgList = [
    {
      "url": "images/HomePage/img1.jpg",
    },
    {
      "url": "images/HomePage/img2.jpg",
    },
    {
      "url": "images/HomePage/img3.jpg",
    },
  ];

  // 延迟加载
  int freshCount = 0;
  _futureRefresh() async {
    while (!Settings.initFinFlag || Settings.daysPerWeek == -1 ||
        !DateCalculator.isDateInit()) {
      LogUtil.v('[Refresh] Settings.initFinFlag ${Settings
          .initFinFlag}, Settings.daysPerWeek: ${Settings
          .daysPerWeek}, DateCalculator.weekIndex: ${DateCalculator
          .weekIndex}');
      await Future.delayed(Duration(milliseconds: 200));
      isFiveDayMode = (Settings.daysPerWeek == 5) ? true : false;
      weekIndex = DateCalculator.weekIndex;
      setState(() {});
    }
    setState(() {});
    // while (true) {
    //   if (Settings.isHomePageNeedRefresh) {
    //     Settings.isHomePageNeedRefresh = false;
    //     setState(() {});
    //   }
    //   await Future.delayed(Duration(seconds: 1));
    // }
  }

  final TextStyle _simpleOptionTextStyle =
      TextStyle(fontSize: 20);
  final TextStyle _simpleOptionTitleTextStyle =
      TextStyle(fontSize: 25, fontWeight: FontWeight.w600);

  DateTime _now = DateTime.now();
  bool isShowDialog = false;

  @override
  Widget build(BuildContext context) {
    // _initCheckUpdate();
    _now = DateTime.now();
    // LogUtil.v("[debug] WeekIndex: ${weekIndex}");
    double appBarHeight = MediaQuery.of(context).padding.top;
    if(MediaQuery.of(context).size.height<750 || MediaQuery.of(context).size.height>1000){
      appBarHeight+=10;
    }
    if (!Settings.initFinFlag && !isShowDialog) {
      _initCheckTasks();
      isShowDialog = true;
    }
    _futureRefresh();
    // LogUtil.v('[HomePage] week: ${DateCalculator.weekIndex}.');
    DatabaseHelper().open();
    // _firstTimeLaunchDialog();
    // DateTime date=DateTime.now();
    return DefaultTabController(
      length: 2,
      child: TabBarView(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Stack(
                      children: [
                        Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return new Image.asset(
                              imgList[index]["url"],
                              fit: BoxFit.fill,
                            );
                          },
                          itemCount: imgList.length,
                          pagination: new SwiperPagination(),
                          loop: true,
                          autoplay: true,
                          onTap: (index) {
                            if (index == 0) {
                              this.callPoliceDialog(context);
                              setState(() {});
                            } else {
                              setState(() {});
                            }
                          },
                        ),
                        Align(
                            alignment: Alignment(-0.8, 0.9),
                            child: Text(
                              "Week ${DateCalculator.weekIndex}",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white),
                            )),
                        Positioned(
                          right: 15,
                          bottom: 0,
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorWeight: 3.0,
                            isScrollable: true,
                            unselectedLabelColor: Colors.grey,
                            unselectedLabelStyle: unselectedTabStyle,
                            labelColor: Colors.black,
                            labelStyle: selectedTabStyle,
                            tabs: <Widget>[
                              Text("Today",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                              Text("Week",
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                  ClassCardList(),
                ],
              ),
            )
          ),
          Scaffold(
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              toolbarHeight: appBarHeight,
              centerTitle: true,
              title: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedItem,
                  onChanged: (String? string) => setState(() {
                    selectedItem = string;
                    // LogUtil.v('[DEBUG] change selectedItem to $string.');
                    if (string != null) {
                      // LogUtil.v('[DEBUG] change week index to $weekIndex.');
                      weekIndex =
                          int.parse(string.substring(1, string.length - 1));
                    }
                  }),
                  selectedItemBuilder: (BuildContext context) {
                    return items.map<Widget>((String item) {
                      return Text(item);
                    }).toList();
                  },
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  isDense: true,
                  iconSize: 30,
                  iconEnabledColor: Colors.black,
                  menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
                  elevation: 12,
                  dropdownColor: Color(0xFFFBFCFB),
                  hint: Text(
                    "Week ${DateCalculator.weekIndex}",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text(
                        item,
                        // style: TextStyle(fontSize: 20),
                      ),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
              actions: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.27,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ImageButton(
                        key: UniqueKey(),
                        title: '',
                        normalImage: isFiveDayMode
                            ? buttonImageProvider(
                                AssetImage("images/HomePage/Five.png"))
                            : buttonImageProvider(
                                AssetImage("images/HomePage/Seven.png")),
                        pressedImage: !isFiveDayMode
                            ? buttonImageProvider(
                                AssetImage("images/HomePage/Five.png"))
                            : buttonImageProvider(
                                AssetImage("images/HomePage/Seven.png")),
                        onPressed: () {
                          isFiveDayMode = !isFiveDayMode;
                          Settings.daysPerWeek = isFiveDayMode ? 5 : 7;
                          setSetting(Settings.daysPerWeek);
                          setState(() {});
                        },
                      ),
                      IconButton(
                        onPressed: () => _graduateDialog(context),
                        icon: Icon(
                          Icons.download_rounded,
                          color: Colors.black,
                        ),
                        iconSize: 25.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Color(0xFFFBFCFB), // 背景背景
                child: Row(
                  children: [
                    SizedBox(width: 5,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: _sidebarProvider(),
                    ),
                    Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            (!isFiveDayMode)
                                ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Mon. ",
                                      style: (_now.weekday == 1 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    Text(
                                      "Tues.",
                                      style: (_now.weekday == 2 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    Text(
                                      "Wed. ",
                                      style: (_now.weekday == 3 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    Text(
                                      "Thur.",
                                      style: (_now.weekday == 4 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    Text(
                                      "Fri. ",
                                      style: (_now.weekday == 5 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    Text(
                                      "Sat. ",
                                      style: (_now.weekday == 6 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    Text(
                                      "Sun. ",
                                      style: (_now.weekday == 7 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: _dateBuilder(weekIndex, isFiveDayMode),
                                ),
                              ],
                            )
                                : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Mon. ",
                                      style: (_now.weekday == 1 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    Text(
                                      "Tues.",
                                      style: (_now.weekday == 2 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    Text(
                                      "Wed.",
                                      style: (_now.weekday == 3 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    Text(
                                      "Thur.  ",
                                      style: (_now.weekday == 4 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    Text(
                                      "Fri. ",
                                      style: (_now.weekday == 5 &&
                                          weekIndex == DateCalculator.weekIndex)
                                          ? _todayLabelStyle
                                          : _dayLabelStyle,
                                    ),
                                    // SizedBox(width: 0.01,)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: _dateBuilder(weekIndex, isFiveDayMode),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            HalfDayCoursesProvider(
                                weekIndex,
                                isFiveDayMode ? 5 : 7,
                                (MediaQuery.of(context).size.width - 68) / (isFiveDayMode ? 5 : 7), 1, 5),
                            _divider(),
                            HalfDayCoursesProvider(
                                weekIndex,
                                isFiveDayMode ? 5 : 7,
                                (MediaQuery.of(context).size.width - 68) / (isFiveDayMode ? 5 : 7), 6, 10),
                            _divider(),
                            HalfDayCoursesProvider(
                                weekIndex,
                                isFiveDayMode ? 5 : 7,
                                (MediaQuery.of(context).size.width - 68) / (isFiveDayMode ? 5 : 7), 11, 13),
                          ]),
                    )
                  ],
                )
              ), //SubjectCalender(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return SizedBox(
      height: _dividerHeight,
    //   child: Center(
    //     child: Container(
    //       height: 4,
    //       margin: EdgeInsetsDirectional.only(start: 20, end: 20),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
    //         color: Colors.grey.shade300,
    //       ),
    //     ),
    //   ),
    );
  }

  _graduateDialog(BuildContext context) {
    showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return  SimpleDialog(
            title: Center(
              child: Text(
                'System',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            children: <Widget>[
              Center(
                child: SimpleDialogOption(
                  child: new Text(
                    'System A',
                    style: TextStyle(fontSize: 21),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UniversityWebRoute(0)))
                      .then((value) {
                      selectedItem = "Week ${DateCalculator.weekIndex}";
                    Navigator.of(context).pop();
                    _refreshTable(200000);
                  }),
                ),
              ),
              Center(
                child: SimpleDialogOption(
                  child: new Text(
                    'System B',
                    style: TextStyle(fontSize: 21),
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UniversityWebRoute(1)))
                      .then((value) {
                    selectedItem = "Week ${DateCalculator.weekIndex}";
                    Navigator.of(context).pop();
                    _refreshTable(200000);
                  }),
                ),
              ),
            ],
          );
        });
  }

  _firstTimeLaunchDialog() {
    showDialog(
      context: context,
      builder: (context) => mDialog(
        "Import courses table?",
        Text.rich(TextSpan(children: [
          TextSpan(text: "If you want to import A system's courses, click the "),
          TextSpan(
            text: "「Import A」 button.",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          TextSpan(
            text: "And if you want to import B system's courses, click the ",
          ),
          TextSpan(
            text: "「Import B」 button.",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          TextSpan(text: "   If you want to set those later, click the space beyond this dialog."),
        ])),
        [
          TextButton(
            child: Text(
              "Import A",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UniversityWebRoute(1))).then((value) {
              _refreshTable(200000);
              Navigator.of(context).pop();
            }),
          ),
          TextButton(
            child: Text(
              "Import B",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UniversityWebRoute(0))).then((value) {
              _refreshTable(200000);
              Navigator.of(context).pop();
            }),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshTable(int us) async {
    await Future.delayed(Duration(microseconds: us));
    LogUtil.v('[DEBUG] refresh!');
    setState(() {
      weekIndex = -1;
    });
    LogUtil.v('[DEBUG] switch!');
    setState(() {
      weekIndex = DateCalculator.weekIndex;
    });
  }

  Future _initCheckDatabaseEmpty() async {
    ClassListGetter courseGetter = ClassListGetter();
    List<Course> ls = await courseGetter.getAllClasses();
    if (ls.length == 0) {
      // Settings.isDatabaseEmpty = true;
      _firstTimeLaunchDialog();
    }
  }

  Future _initCheckUpdate() async {
    UpdateUtil update = UpdateUtil(context);
    update.checkUpdate(AUTO_CHECK);
  }

  _initCheckTasks() async {
    await Future.wait([_initCheckUpdate(),_initCheckDatabaseEmpty()]);
    Settings.initFinFlag = true;
  }

  List<Widget> _dateBuilder(int weekIndex, bool isFiveDayMode) {
    List<Widget> result = [];
    for (int i = 0; i < (isFiveDayMode ? 5 : 7); i++) {
      DateTime selectTime = DateCalculator.semesterStartDate
          .add(Duration(days: (weekIndex - 1) * 7 + i));
      // selectTime.weekday
      result.add(
        Text(
          '${selectTime.month}/${selectTime.day.toString().padLeft(2,"0")}',
          style: (_now.day == selectTime.day && _now.month == selectTime.month)
              ? _todayDateLabelStyle
              : _dateLabelStyle,
        ),
      );
    }
    return result;
  }

  final TextStyle _dayLabelStyle = TextStyle(fontSize: 18);
  final TextStyle _dateLabelStyle = TextStyle(fontSize: 13, color: Colors.grey);
  TextStyle _todayLabelStyle = TextStyle(
      color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.w600);
  TextStyle _todayDateLabelStyle = TextStyle(
      color: Colors.blueAccent, fontSize: 13, fontWeight: FontWeight.w600);

  final TextStyle selectedTabStyle = TextStyle(
    fontSize: 18,
    color: Colors.black,
  );
  final TextStyle unselectedTabStyle = TextStyle(
    fontSize: 18,
    color: Colors.grey,
  );


  void callPoliceDialog(BuildContext context) {
    showDialog<Null>(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: Center(
              child: Text(
                'Dial to:',
                style: _simpleOptionTitleTextStyle,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            children: <Widget>[
              Center(
                child: SimpleDialogOption(
                  child: Text(
                    '112',
                    style: _simpleOptionTextStyle,
                  ),
                  onPressed: () {
                    launch("tel://112");
                  },
                ),
              ),
              Center(
                child: SimpleDialogOption(
                  child: Text(
                    '911',
                    style: _simpleOptionTextStyle,
                  ),
                  onPressed: () {
                    launch("tel://911");
                  },
                ),
              ),
            ],
          );
        }
    );
  }

  List<Widget> _sidebarProvider(){
    List<Widget> result=[];
    result.add(SizedBox(height: MediaQuery.of(context).padding.top + 12,));
    for(int i=1; i<14; i++){
      result.add(
        Container(
          // decoration: BoxDecoration(
          //   border:  Border.all(color: Colors.grey.shade300, width: 1),
          // ),
          height: 54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(i.toString(),style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold),),
              Text(startIndex2TimeMap[i]!, style: TextStyle(fontSize: 11, color: Colors.grey.shade700),),
              Text(endIndex2TimeMap[i]!, style: TextStyle(fontSize: 11,color: Colors.grey.shade700),),
              // SizedBox(height: 6,),
            ],
          ),
        ),
      );
    }
    result.insert(6, SizedBox(height: _dividerHeight + 1,));
    result.insert(12, SizedBox(height: _dividerHeight + 1,));
    return result;
  }
  double _dividerHeight = 7;

  final List<String> items = <String>[
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
    'Week 5',
    'Week 6',
    'Week 7',
    'Week 8',
    'Week 9',
    'Week 10',
    'Week 11',
    'Week 12',
    'Week 13',
    'Week 14',
    'Week 15',
    'Week 16',
    'Week 17',
    'Week 18',
  ];
}
