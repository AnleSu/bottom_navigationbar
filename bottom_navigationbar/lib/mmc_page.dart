import 'package:flutter/material.dart';

class BanchItem extends StatelessWidget {
  final int number;
  final String title;
  final String imgName;
  BanchItem({this.number, this.title, this.imgName});
  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,
        child: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Image.asset(
              this.imgName,
              
            ),
            Container(
              width: 14,
              height: 12,
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 15),
              child: new Text(
                '${this.number}',
                style: new TextStyle(
                  color: Color(0xFFFDFDFD),
                  fontSize: 6,
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFF12E49),
                borderRadius: BorderRadius.circular(6.6),
              ),
            )
          ],
        ),
        Text(
          this.title,
          textAlign: TextAlign.center,
          style: new TextStyle(
            fontSize: 12.0,
            color: Color(0xFF333333),
          )
        )
      ],
    ));
  }
}

class MMCPage extends StatefulWidget {
  @override
  _MMCPageState createState() => _MMCPageState();
}

class _MMCPageState extends State<MMCPage> with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 200));
    animation = new Tween(begin: 0.0, end: 0.5).animate(animationController);
  }

  _changeTrailing(bool expand) {
    setState(() {
      if (expand) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFF8F8F8),
        child: Column(
          children: <Widget>[
            ExpansionTile(
              backgroundColor: Colors.white,
              title: new Text(
                '留资单',
                style: new TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: RotationTransition(
                turns: animation,
                child: Image.asset('assets/images/收起.png'),
              ),
              onExpansionChanged: (expand) {
                _changeTrailing(expand);
              },
              initiallyExpanded: true,
              children: <Widget>[
                BanchItem(
                  title: '待接单',
                  imgName: 'assets/images/待接单.png',
                  number: 7,
                )
              ],
            ),
          ],
        ));
  }
}
