import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'order_model.dart';
import 'dart:convert' show json;

class OrderRow extends StatelessWidget {
  //初始值 写在这里是不起作用的
  bool cancelFlag;
  String memberName = "李二狗";
  String customerTel;
  String dynamicBottom = "2018/11/12创建";
  String orderNo;
  bool selfFlag;
  String productName = "2014雪铁龙新爱丽舍/三厢/1.6自动";
  String color;
  String label = "全款";
  GestureTapCallback onTap;

  OrderRow(
      {this.cancelFlag,
      this.memberName = "李二狗",
      this.customerTel,
      this.dynamicBottom = "2018/11/12创建",
      this.orderNo,
      this.selfFlag,
      this.productName = "2014雪铁龙新爱丽舍/三厢/1.6自动",
      this.color,
      this.label = "全款",
      this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
            height: 108,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(color: Color(0xFFF5F5F5), width: 10),
            )),
            child: Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Divider(
                        height: 10,
                        color: Colors.red,
                      ),
                      Text(
                        '$memberName',
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '$productName',
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '$dynamicBottom',
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      '$label',
                    ),
                  )
                ],
              ),
            )));
  }
}

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> modelList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _saveOrderJson() async {
      var db = DatabaseHelper();
      String jsonStr = await DefaultAssetBundle.of(context)
          .loadString("assets/json/order.json");
      List list = json.decode(jsonStr);
      List<Order> modelList = list.map((item) => Order.fromJson(item)).toList();
      await db.batchInsertOrders(modelList);
      // modelList.forEach((v) => db.insertOrder(v));
      
      await db.close();
    }

    _getOrderFromDB() async {
      var db = DatabaseHelper();
      modelList = await db.selectAllOrders();
      print('model list count is ${modelList.length}');
      await db.close();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('列表'),
        ),
        body: 
        // FutureBuilder(
        //     future: _getOrderFromDB(),
        //     builder: (context, snap) {
        //       return ListView.builder(
        //           itemCount: modelList.length,
        //           itemBuilder: (context, index) {
        //             Order model = modelList[index];
        //             return OrderRow(
        //               memberName: model.memberName,
        //               productName: model.productName,
        //               dynamicBottom: model.dynamicBottom,
        //               label: model.dynamicStatus.label,
        //             );
        //           },
        //         );
        //       // if (snap.hasData) {
        //       //   return ListView.builder(
        //       //     itemCount: modelList.length,
        //       //     itemBuilder: (context, index) {
        //       //       Order model = modelList[index];
        //       //       return OrderRow(
        //       //         memberName: model.memberName,
        //       //         productName: model.productName,
        //       //         dynamicBottom: model.dynamicBottom,
        //       //         label: model.dynamicStatus.label,
        //       //       );
        //       //     },
        //       //   );
        //       // } else {
        //       //   return Container();
        //       // }
        //     })
        Container(
          width: 100,
          height: 100,
          child: InkWell(
            child: Text('点击保存一条数据'),
            onTap: () {
              _saveOrderJson();
            },
          )
        )

        );
  }
}
