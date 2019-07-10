import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with AutomaticKeepAliveClientMixin {
  int count = 0;

  void add() {
    setState(() {
      count++;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('攻略资讯 initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Center(child: Text('攻略资讯: $count', style: TextStyle(fontSize: 30))),
        floatingActionButton: FloatingActionButton(
          onPressed: add,
          child: Icon(Icons.add),
          heroTag: null,
        ));
  }
}
