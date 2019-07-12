import 'package:flutter/material.dart';

class MineHeader extends StatefulWidget {
  final String imgName;
  final String name;
  final String phone;
  MineHeader({this.imgName, this.name, this.phone});
  @override
  _MineHeaderState createState() => _MineHeaderState();
}

class _MineHeaderState extends State<MineHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 15, top: 50),
      height: 190,
      width: double.infinity,
      color: Color(0xFFF12E49),
      child: Column(
        children: <Widget>[
          Text('我的',
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 18,
                color: Colors.white,
              )),
          SizedBox(
            height: 17,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    widget.imgName,
                    width: 57,
                    height: 57,
                  ),
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(left: 21),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.name,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          widget.phone,
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 0),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage>
    with AutomaticKeepAliveClientMixin {
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
        body: Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              new MineHeader(
                imgName: 'assets/images/头像.png',
                name: '用户名',
                phone: '13000000001',
              ),
              Container(
                height: 85,
                margin: EdgeInsets.only(left: 8,right: 8,top: 160),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4)
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
