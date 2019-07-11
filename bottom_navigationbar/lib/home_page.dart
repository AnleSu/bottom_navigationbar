import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'yz_page.dart';
import 'mmc_page.dart';
import 'zc_page.dart';

class _TabData {
  final Widget tab;
  final Widget page;
  _TabData({this.tab, this.page});
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  int count = 0;
  static var tabList = <_TabData>[
    _TabData(tab:Text('驿站'),page: YZPage()),
    _TabData(tab:Text('买买车'),page: MMCPage()),
    _TabData(tab:Text('资产'),page: ZCPage()),
  ];

  final tabbarList = tabList.map((item) => item.tab).toList();
  final tabPageList = tabList.map((item) => item.page).toList();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('工作台 initState');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabList.length,
      child: Column(
        children: <Widget>[
            Container(
              width: double.infinity,
              height: 84,
              padding: EdgeInsets.fromLTRB(20, 50, 0, 0),
              alignment: Alignment.center,
              color: Colors.white,
              child: TabBar(
                  isScrollable: true,
                  indicatorColor: Color(0xFFF12E49),
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: Color(0xFFFAEAEAE),
                  unselectedLabelStyle: TextStyle(fontSize: 15),
                  labelColor: Color(0xFF333333),
                  labelStyle: TextStyle(fontSize: 15),
                  tabs: tabbarList),
            ),
            Expanded(
                child: TabBarView(
              children: tabPageList,
            ))
          ],
      ),
    );
  }
}
