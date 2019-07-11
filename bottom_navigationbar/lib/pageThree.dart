
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
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            pageController.jumpToPage(i);
            // index = i;
          });
          
        },
        selectedItemColor: Color(0xFFF12E49),
        unselectedItemColor: Color(0xFF898A8D),
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
      
      
       body: PageView(
         controller: pageController,
         children: bodyList,
         physics: NeverScrollableScrollPhysics(),//禁止滑动
         onPageChanged: (int i) {
           setState(() {
            index = i;//改变index要写在这里 修复侧滑切换页面bottombar的currentIndex不改变的问题
          });
         },
       )
      
    );
  }
}