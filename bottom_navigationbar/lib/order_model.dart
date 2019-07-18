import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Order {
  String memberName;
  String customerPhone;
  String dynamicBottom;
  String productName;
  StatusModel dynamicStatus;
  String orderNo;

  Order(
      {this.memberName,
      this.customerPhone,
      this.dynamicBottom,
      this.productName,
      this.dynamicStatus,
      this.orderNo});

  // Order.fromJson(Map<String, dynamic> json) {
  //  memberName = json['memberName'];
  //     customerPhone = json['customerPhone'];
  //     dynamicBottom = json['dynamicBottom'];
  //     productName = json['productName'];
  //     dynamicStatus = StatusModel.fromJson(json['dynamicStatus'];
  // }

  Order.fromJson(Map json)
      : memberName = json['memberName'],
        customerPhone = json['customerPhone'],
        dynamicBottom = json['dynamicBottom'],
        productName = json['productName'],
        dynamicStatus = StatusModel.fromJson(json['dynamicStatus']),
        orderNo = json['orderNo'];

  Order.fromSql(Map<String, dynamic> json) {
    memberName = json['memberName'];
    customerPhone = json['customerPhone'];
    dynamicBottom = json['dynamicBottom'];
    productName = json['productName'];
    StatusModel statusModel = new StatusModel(json['color'], json['label']);
    dynamicStatus = statusModel;
    orderNo = json['orderNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['memberName'] = this.memberName;
    data['customerPhone'] = this.customerPhone;
    data['dynamicBottom'] = this.dynamicBottom;
    data['productName'] = this.productName;
    data['color'] = this.dynamicStatus.color;
    data['label'] = this.dynamicStatus.label;
    data['orderNo'] = this.orderNo;
    return data;
  }
}

class StatusModel {
  final String color;
  final String label;

  StatusModel(
    this.color,
    this.label,
  );

  StatusModel.fromJson(Map json)
      : color = json['color'],
        label = json['label'];
}

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableOrder = 'OrderTable'; //表名称
  //每列名称
  final String columnId = 'id';
  final String memberName = 'memberName';
  final String dynamicBottom = 'dynamicBottom';
  final String productName = 'productName';
  final String customerPhone = 'customerPhone';
  final String color = 'color';
  final String label = 'label';
  final String orderNo = 'orderNo';

  static Database _db;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null && _db.isOpen) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'orderlist.db');
    print('$path');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableOrder ($columnId INTEGER PRIMARY KEY, $memberName TEXT, $dynamicBottom TEXT, $productName TEXT, $customerPhone TEXT, $color TEXT, $label TEXT, $orderNo TEXT)');
  }

  Future<int> insertOrder(Order order) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      var result = await txn.insert(tableOrder, order.toJson());

      return result;
    });
  }

  Future<List> batchInsertOrders(List<Order> orders) async {
    var dbClient = await db;
    // Batch batch = dbClient.batch();
    //   orders.forEach((v) => batch.insert(tableOrder, v.toJson()));
    //   var result = await batch.commit();
    //   return result;
    await dbClient.transaction((txn) async {
      Batch batch = txn.batch();
      orders.forEach((v) => batch.insert(tableOrder, v.toJson()));
      var result = await batch.commit();
      return result;
    });
  }

  Future<List> selectAllOrders() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery('SELECT * FROM $tableOrder');
    List<Order> orders = [];
    result.forEach((item) => orders.add(Order.fromSql(item)));
    return orders;
  }

  Future<List> selectOrders({int limit, int offset}) async {
    var dbClient = await db;
    var result = await dbClient.query(
      tableOrder,
      columns: [columnId, memberName, customerPhone, productName, color, label],
      limit: limit,
      offset: offset,
    );
    List<Order> orders = [];
    result.forEach((item) => orders.add(Order.fromSql(item)));
    return orders;
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableOrder'));
  }

  Future<Order> getOrder(int id) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(tableOrder,
        columns: [
          columnId,
          memberName,
          customerPhone,
          productName,
          color,
          label
        ],
        where: '$id = ?',
        whereArgs: [id]);

    if (result.length > 0) {
      return Order.fromSql(result.first);
    }

    return null;
  }

  Future<int> deleteNote(int id) async {
    var dbClient = await db;
    return await dbClient.delete(tableOrder, where: '$id = ?', whereArgs: [id]);
  }

  Future<int> updateNote(Order order) async {
    var dbClient = await db;
    return await dbClient.update(tableOrder, order.toJson(),
        where: "$orderNo = ?", whereArgs: [order.orderNo]);
  }

  close() async {
    var dbClient = await db;
    dbClient.close();
    // _db = null;
  }
}
