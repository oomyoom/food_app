import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:food_app/utils/getToken.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<dynamic> notification = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    List<dynamic> notificationData =
        await getAllNotification(); // รอให้ Future ทำงานเสร็จ

    if (mounted) {
      // Check if the widget is still mounted before updating state
      setState(() {
        notification = notificationData;
      });
    }
  }

  Future<List<dynamic>> getAllNotification() async {
    final token = await getToken();

    final response = await http.get(
      Uri.parse('http://192.168.1.84:3333/order/notification'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> allNotification = json.decode(response.body);
      return allNotification;
    } else {
      // กรณีเกิดข้อผิดพลาดในการรับข้อมูล
      return [];
    }
  }

  Future<void> notificationReaded(int orderId) async {
    final token = await getToken();

    await http.patch(Uri.parse('http://192.168.1.84:3333/order/readed'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'order_id': orderId}));
  }

  Future<void> orderRecieved(int orderId) async {
    final token = await getToken();

    final response =
        await http.patch(Uri.parse('http://192.168.1.84:3333/order/recieved'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'order_id': orderId}));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ได้รับออเดอร์เรียบร้อย'),
          duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
        ),
      );
    } else {
      // กรณีเกิดข้อผิดพลาดในการรับข้อมูล
    }
  }

  Future<void> _showConfirmationDialog(
      BuildContext context, int order_id) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ยืนยัน'),
          content: Text('คุณได้แล้วรับออเดอร์แล้วใช่ไหม'),
          actions: <Widget>[
            TextButton(
              child: Text('ใช่'),
              onPressed: () {
                notificationReaded(order_id);
                orderRecieved(order_id);
                fetchData();
                Navigator.of(context).pop(); // ปิด dialog
              },
            ),
            TextButton(
              child: Text('ไม่'),
              onPressed: () {
                // ทำสิ่งที่คุณต้องการเมื่อผู้ใช้กด Yes ที่นี่
                Navigator.of(context).pop(); // ปิด dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'แจ้งเตือน'.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: notification.asMap().entries.map((entry) {
              final value = entry.value;

              return Column(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03),
                        color: kMainColor,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'หมายเลขออเดอร์ ${value['order_id']}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: const BoxDecoration(
                            border: Border(
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                                right: BorderSide(
                                    color: Colors.black12, width: 1))),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ออเดอร์ของคุณเสร็จเรียบร้อย',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.03),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black12, width: 1),
                                left:
                                    BorderSide(color: Colors.black12, width: 1),
                                right: BorderSide(
                                    color: Colors.black12, width: 1))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ได้รับออเดอร์หรือยัง?',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _showConfirmationDialog(
                                        context, value['order_id']);
                                  },
                                  icon: Icon(Icons.check_circle),
                                  color: kActiveColor,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  )
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
