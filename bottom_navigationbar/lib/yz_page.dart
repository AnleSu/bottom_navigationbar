import 'package:flutter/material.dart';

class Item {
  String name;
  MaterialColor color;
  IconData icon;
  Item(this.name, this.color, this.icon);
}

List<Item> items = [
  Item('壹', Colors.amber, Icons.adjust),
  Item('贰', Colors.cyan, Icons.airport_shuttle),
  Item('叁', Colors.indigo, Icons.android),
  Item('肆', Colors.green, Icons.beach_access),
  Item('伍', Colors.pink, Icons.attach_file),
  Item('陸', Colors.blue, Icons.bug_report)
];

class CardItem extends StatelessWidget {
  CardItem({this.item});

  final Item item;
  
   static final Shadow _shadow =
      Shadow(offset: Offset(2.0, 2.0), color: Colors.black26);
  final TextStyle _style = TextStyle(color: Colors.white70, shadows: [_shadow]);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 1, color: Colors.black26),
        borderRadius: BorderRadius.circular(32),
      ),
      color: item.color.withOpacity(.7),
      child: Container(
        constraints: BoxConstraints.expand(height: 150),
        child: RawMaterialButton(
          onPressed: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(item.name, style: _style.copyWith(fontSize: 64)),
                  Icon(item.icon, color: Colors.white70, size: 72),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AnimationBack extends StatefulWidget {
  final ScrollController controller;
  AnimationBack({this.controller});
  @override
  _AnimationBackState createState() => _AnimationBackState();
}

class _AnimationBackState extends State<AnimationBack> {
  get offset => widget.controller.hasClients ? widget.controller.offset : 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: widget.controller, builder: (BuildContext context, Widget child) {

      return OverflowBox(
        maxWidth: double.infinity,
        alignment: Alignment(4, 3),
        child: Transform.rotate(
          angle: offset / -512,
          child: Icon(Icons.settings, size:512, color:Colors.red),
        ),
      );
    },
      
    );
  }
}
class YZPage extends StatefulWidget {
  
  @override
  _YZPageState createState() => _YZPageState();
}

class _YZPageState extends State<YZPage> {
  ScrollController _controller = new ScrollController();
  List<CardItem> _cards = items.map((Item item) => CardItem(item: item,)).toList();
  @override
  Widget build(BuildContext context) {
    return Stack(
      
      alignment: AlignmentDirectional.topCenter,
      children: <Widget>[
        AnimationBack(controller: _controller,),
        Container(child: ListView(controller: _controller, children: _cards,),),
      ],
      
    );
  }
}