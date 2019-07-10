import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin {
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
    print('我的 initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Center(child: Text('我的: $count', style: TextStyle(fontSize: 30))),
        floatingActionButton: FloatingActionButton(
          onPressed: add,
          child: Icon(Icons.add),
          heroTag: null,
        ));
  }
}