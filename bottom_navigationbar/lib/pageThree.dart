
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'message_page.dart';
import 'mine_page.dart';

class PageThree extends StatefulWidget {
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
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
      
      
       body: Stack(
          children: [
            Offstage(
              offstage: index != 0,
              child: bodyList[0],
            ),
            Offstage(
              offstage: index != 1,
              child: bodyList[1],
            ),
            Offstage(
              offstage: index != 2,
              child: bodyList[2],
            ),
          ],
        )
       
      
    );
  }
}