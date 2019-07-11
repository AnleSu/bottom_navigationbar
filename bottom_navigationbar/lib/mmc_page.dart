import 'package:flutter/material.dart';

class BanchItem extends StatelessWidget {
  final int number;
  final String title;
  final String imgName;
  BanchItem({this.number, this.title, this.imgName});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
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
                    number > 0 ? '${this.number}' : '',
                    style: new TextStyle(
                      color: Color(0xFFFDFDFD),
                      fontSize: 6,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: number > 0 ? Color(0xFFF12E49) : Colors.transparent,
                    borderRadius: BorderRadius.circular(6.6),
                  ),
                )
              ],
            ),
            Text(this.title,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFF333333),
                ))
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
  final List lzData = <Widget>[
    BanchItem(
      title: '待接单',
      imgName: 'assets/images/待接单.png',
      number: 7,
    ),
    BanchItem(
      title: '跟进中',
      imgName: 'assets/images/待接单.png',
      number: 0,
    ),
    BanchItem(
      title: '留资查询',
      imgName: 'assets/images/待接单.png',
      number: 0,
    ),
    BanchItem(
      title: '拉新邀请',
      imgName: 'assets/images/待接单.png',
      number: 0,
    ),
  ];

  final List orderData = <Widget>[
    BanchItem(
      title: '待确认',
      imgName: 'assets/images/待接单.png',
      number: 7,
    ),
    BanchItem(
      title: '风控订单',
      imgName: 'assets/images/待接单.png',
      number: 0,
    ),
    BanchItem(
      title: '待签约',
      imgName: 'assets/images/待接单.png',
      number: 0,
    ),
    BanchItem(
      title: '已休眠',
      imgName: 'assets/images/待接单.png',
      number: 0,
    ),
  ];

  bool orderExpand = true;

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
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10),
              child: InkWell(
                onTap: () {
                  print("点击切换门店");
                },
                child: Container(
                  height: 35,
                  padding: EdgeInsets.only(left: 56,right: 56),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('全部门店',
                          style: new TextStyle(
                            fontSize: 15,
                            color: Color(0xFF333333),
                          )),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 28,
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(59),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ExpansionTile(
                backgroundColor: Colors.white,
                title: new Text(
                  '留资单',
                  style: new TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 18,
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
                  Wrap(
                    runSpacing: 10,
                    spacing: 10,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: lzData,
                  ),
                  Container(
                    height: 20,
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ExpansionPanelList(
                  expansionCallback: (index, expand) {
                    setState(() {
                      orderExpand = !orderExpand;
                    });
                  },
                  children: [
                    ExpansionPanel(
                        isExpanded: orderExpand,
                        headerBuilder: (context, expand) {
                          return ListTile(
                            title: new Text(
                              '订单',
                              style: new TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 18,
                              ),
                            ),
                            //不支持自定义右侧icon
                            // trailing: RotationTransition(
                            //   turns: animation,
                            //   child: Image.asset('assets/images/收起.png'),
                            // ),
                          );
                        },
                        body: Column(
                          children: <Widget>[
                            Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              runAlignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: orderData,
                            ),
                            Container(
                              height: 20,
                            )
                          ],
                        ))
                  ],
                ))
          ],
        )));
  }
}
