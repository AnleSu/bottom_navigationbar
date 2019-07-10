import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
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
    print('工作台 initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Center(child: Text('工作台: $count', style: TextStyle(fontSize: 30))),
        floatingActionButton: FloatingActionButton(
          onPressed: add,
          child: Icon(Icons.add),
          heroTag: null,
        ));
  }
}
