import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_app/screens/queue/components/statusContainer.dart';
import 'package:food_app/utils/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class QueueScreen extends StatefulWidget {
  const QueueScreen({Key? key}) : super(key: key);

  @override
  _QueueScreenState createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  List queue = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    Timer.periodic(Duration(seconds: 5), (timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    List<dynamic> queueData = await getAllOrder(); // รอให้ Future ทำงานเสร็จ

    if (mounted) {
      setState(() {
        queue = queueData; // อัปเดตค่า queue หลังจาก Future ทำงานเสร็จ
      });
    }
  }

  Future<List<dynamic>> getAllOrder() async {
    final response = await http.get(
      Uri.parse('http://192.168.1.84:3333/order/queue'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> queue = json.decode(response.body);
      return queue;
    } else {
      // กรณีเกิดข้อผิดพลาดในการรับข้อมูล
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    switch (queue.length) {
      case 0:
        color = Colors.black26;
        break;
      default:
        if (queue.length <= 10) {
          color = Colors.green;
        }
        if (queue.length > 10) {
          color = Colors.red;
        }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kMainColor,
        centerTitle: true,
        title: Text(
          'คิว'.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Text(
                            'จำนวนคิว',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.black),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black26, width: 1))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StatusContainer.colorContainer(context, color),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Text('${queue.length}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: kActiveColor)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.5,
                            color: kMainColor,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                children: [
                                  Text(
                                    'หมายเลขคิว',
                                    style:
                                        Theme.of(context).textTheme.titleLarge!,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Column(
                                    children:
                                        queue.asMap().entries.map((entry) {
                                      final value = entry.value;

                                      return Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01),
                                            child: Text(
                                              '${value['order_id']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!,
                                            ),
                                          )
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(defaultPadding),
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatusContainer(color: Colors.black26, title: '0'),
                    StatusContainer(color: Colors.green, title: '<= 10'),
                    StatusContainer(color: Colors.red, title: '> 10'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
