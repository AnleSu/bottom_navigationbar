import 'package:flutter/material.dart';
import 'home_page.dart';
import 'message_page.dart';
import 'mine_page.dart';

//从第二页切换回第一页时，第一页的状态已经丢失
class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  final List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home),title: Text('工作台')),
    BottomNavigationBarItem(icon: Icon(Icons.message),title: Text('资讯攻略')),
    BottomNavigationBarItem(icon: Icon(Icons.person),title: Text('我的')),
  ];
  int index = 0;
  final bodyList = [HomePage(),MessagePage(),MinePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
          });
          
        },
        selectedItemColor: Color(0xFFF12E49),
        unselectedItemColor: Color(0xFF898A8D),
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
      body: bodyList[index],
    );
  }
}
