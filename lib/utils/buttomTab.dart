import 'package:flutter/material.dart';
import 'package:food_app/screens/history/orderHistory_screen.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/notifcation/notification_screen.dart';
import 'package:food_app/screens/profile/profile_screen.dart';
import 'package:food_app/screens/queue/queue_screen.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/utils/getToken.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ButtomTab extends StatefulWidget {
  const ButtomTab({Key? key, required this.initialIndex}) : super(key: key);
  final int initialIndex;

  @override
  _ButtomTabState createState() => _ButtomTabState();
}

class _ButtomTabState extends State<ButtomTab> {
  late Timer _notificationTimer;
  int unreadNotificationCount = 0; // เริ่มต้นที่ 0
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const QueueScreen(),
    const OrderHistoryScreen(),
    const ProfileScreen(),
    const NotificationScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Initialize the initial index

    final notificationData = getAllNotification();
    notificationData.then((data) {
      setState(() {
        unreadNotificationCount =
            data.where((item) => !(item['isReaded'] == 1)).length;
      });
    });

    _notificationTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final notificationData = getAllNotification();
      notificationData.then((data) {
        if (mounted) {
          // Check if the widget is still in the tree
          setState(() {
            unreadNotificationCount =
                data.where((item) => !(item['isReaded'] == 1)).length;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _notificationTimer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
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

  void setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: kMainColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 28,
              color: _currentIndex == 0 ? kMainColor : Colors.grey,
            ),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.query_builder,
              size: 28,
              color: _currentIndex == 1 ? kMainColor : Colors.grey,
            ),
            label: 'คิว',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              size: 28,
              color: _currentIndex == 2 ? kMainColor : Colors.grey,
            ),
            label: 'ประวัติ',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 28,
              color: _currentIndex == 3 ? kMainColor : Colors.grey,
            ),
            label: 'โปรไฟล์',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Icon(
                  Icons.notifications,
                  size: 28,
                  color: _currentIndex == 4 ? kMainColor : Colors.grey,
                ),
                if (unreadNotificationCount > 0)
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        unreadNotificationCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'แจ้งเตือน',
          ),
        ],
      ),
    );
  }
}
