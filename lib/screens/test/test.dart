import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/getToken.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  List test = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    List<dynamic> testData =
        await getAllNotification(); // รอให้ Future ทำงานเสร็จ

    setState(() {
      test = testData; // อัปเดตค่า queue หลังจาก Future ทำงานเสร็จ
    });
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

    final response =
        await http.patch(Uri.parse('http://192.168.1.84:3333/order/readed'),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'order_id': orderId}));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('อ่านแล้วเรียบร้อย'),
          duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
        ),
      );
    } else {
      // กรณีเกิดข้อผิดพลาดในการรับข้อมูล
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'test'.toUpperCase(),
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
            children: test.asMap().entries.map((entry) {
              final value = entry.value;

              return Column(
                children: [
                  InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    onTap: () {
                      notificationReaded(value['order_id']);
                      fetchData();
                    },
                    child: Column(
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
                                  bottom: BorderSide(
                                      color: Colors.black12, width: 1),
                                  left: BorderSide(
                                      color: Colors.black12, width: 1),
                                  right: BorderSide(
                                      color: Colors.black12, width: 1))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'ออเดอร์ของคุณเสร็จเรียบร้อย',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Icon(
                                (value['isReaded'] == 0)
                                    ? Icons.check_circle
                                    : Icons.circle, // เลือกรูปไอคอนตามความสถานะ
                                color: (value['isReaded'] == 0)
                                    ? kActiveColor
                                    : Colors
                                        .grey, // ใช้สีเทาหรือเขียวตามความสถานะ
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
