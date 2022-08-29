// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, no_logic_in_create_state, prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:uni_campus/resource/PhoneNumber.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class TelephonePage extends StatefulWidget {
  TelephonePage({Key? key}) : super(key: key);

  @override
  _TelephonePageState createState() => _TelephonePageState();
}

class _TelephonePageState extends State<TelephonePage> with SingleTickerProviderStateMixin {
  late TabController _firstId;
  int _secondLength = 0;

  @override
  void initState() {
    super.initState();
    _firstId = TabController(vsync: this, length: telephoneData.length);
    _firstId.addListener(() {});
  }

  List<Widget> _getFirstTitle() {
    var tmpList = telephoneData.map((value) {
      String title = value.keys.toList()[0];
      return Tab(text: title);
    });
    return tmpList.toList();
  }

  List<Widget> _getViewList() {
    List secondTitleList = telephoneData[0].values.toList()[0];
    _secondLength = secondTitleList.length;
    List<Widget> list = [SecondTitle(0, _secondLength)];

    for (int i = 1; i < telephoneData.length; i++) {
      List secondTitleList = telephoneData[i].values.toList()[0];
      _secondLength = secondTitleList.length;
      list.add(SecondTitle(i, _secondLength));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Yellow Pages",
          style: TextStyle(color: Colors.blue[600]),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        bottom: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blue[600],
          controller: _firstId,
          isScrollable: true,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          tabs: _getFirstTitle(),
        ),
      ),
      body: TabBarView(
        controller: _firstId,
        children: _getViewList(),
      ),
    );
  }
}

class SecondTitle extends StatefulWidget {
  int _firstIdIndex;
  int _secondLength;

  SecondTitle(this._firstIdIndex, this._secondLength, {Key? key})
      : super(key: key);

  @override
  _SecondTitleState createState() =>
      _SecondTitleState(_firstIdIndex, _secondLength);
}

class _SecondTitleState extends State<SecondTitle>
    with SingleTickerProviderStateMixin {
  int _firstIdIndex;
  int _secondLength;
  late TabController _secondId; // 二级标题选项

  _SecondTitleState(this._firstIdIndex, this._secondLength);

  @override
  void initState() {
    super.initState();
    _secondId = TabController(vsync: this, length: _secondLength);
    // 监听页面变化
    _secondId.addListener(() {});
  }

  List<Widget> _getSecondTitle() {
    List<Map> tmpList =
    telephoneData[_firstIdIndex].values.toList()[0].toList();
    var tmpList2 = tmpList.map(
          (value) {
        String title = value.keys.toList()[0];
        return Tab(text: title);
      },
    );
    return tmpList2.toList();
  }

  List<Widget> _getViewList() {
    List<Widget> list = [];
    for (int i = 0;
    i < telephoneData[_firstIdIndex].values.toList()[0].toList().length;
    i++) {
      list.add(
        Content(_firstIdIndex, i),
      );
    }
    return list;
  }

  List<Widget> _getMoreSecondTitle() {
    List<Map> tmpList =
    telephoneData[_firstIdIndex].values.toList()[0].toList();
    var tmpList2 = tmpList.asMap().entries.map(
          (entry) {
        String title = entry.value.keys.toList()[0];
        return InkWell(
          child: Container(
            child: Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            padding: EdgeInsets.fromLTRB(18, 6, 18, 6),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
          onTap: () {
            _secondId.index = entry.key;
            Navigator.of(context).pop();
          },
        );
      },
    );
    return tmpList2.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Container(
          child: TabBar(
            controller: _secondId,
            isScrollable: true,
            tabs: _getSecondTitle(),
            labelColor: Colors.blue[600],
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
          ),
        ),
        actions: [
          Container(
            child: IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return Container(
                      height: 660,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Wrap(children: _getMoreSecondTitle()),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            width: 4,
          )
        ],
      ),
      body: TabBarView(
        controller: _secondId,
        children: _getViewList(),
      ),
    );
  }
}

class Content extends StatelessWidget {
  final int _firstIdIndex, _secondId;
  const Content(this._firstIdIndex, this._secondId, {Key? key})
      : super(key: key);

  List allPhone(String input) {
    RegExp mobile = RegExp(r"\d{8}");
    Iterable<Match> mobiles = mobile.allMatches(input);
    List phoneList = [];
    for (Match m in mobiles) {
      phoneList.add(m.group(0));
    }
    return phoneList;
  }

  List<Widget> _getCallList(String phoneStr) {
    List phoneList = allPhone(phoneStr);
    List<Widget> list = [];
    for (var e in phoneList) {
      list.add(
        InkWell(
          child: ListTile(
            title: Text(e),
          ),
          onTap: () {
            launch("tel:$e");
          },
        ),
      );
    }
    return list;
  }

  List<Widget> _getData(BuildContext context) {
    Map tempList = telephoneData[_firstIdIndex]
        .values
        .toList()[0]
        .toList()[_secondId]
        .values
        .toList()[0];
    List keyList = tempList.keys.toList();
    List valueList = tempList.values.toList();
    List<Widget> showList = [Text("No data")];
    if (keyList.isNotEmpty) {
      showList.clear();
    }
    for (int i = 0; i < keyList.length; i++) {
      showList.add(
        Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
          height: 60,
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
                  child: Text(keyList[i]),
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 20, 0),
                  child: Text(valueList[i]),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  child: Icon(
                    Icons.call,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return Container(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Wrap(
                              children: [
                                ListTile(
                                  title: Text(
                                    "Call",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Wrap(
                                  children: _getCallList(valueList[i]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
    return showList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: _getData(context),
      ),
    );
  }
}
