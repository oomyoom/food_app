import 'package:flutter/material.dart';
import 'package:food_app/screens/history/orderHistory_screen.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/screens/profile/profile_screen.dart';
import 'package:food_app/screens/queue/queue_screen.dart';
import 'package:food_app/utils/constants.dart';

class ButtomTab extends StatefulWidget {
  const ButtomTab({Key? key, required this.initialIndex}) : super(key: key);
  final int initialIndex;

  @override
  _ButtomTabState createState() => _ButtomTabState();
}

class _ButtomTabState extends State<ButtomTab> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const QueueScreen(),
    const OrderHistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // กำหนดค่าเริ่มต้นใน initState
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
        ],
      ),
    );
  }
}
