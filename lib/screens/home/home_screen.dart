// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/screens/home/components/imageCarousel.dart';
import 'package:food_app/screens/menu/food_details_screen.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/screens/menu/menu_screen.dart';
import 'package:food_app/screens/home/components/cardInfo.dart';
import 'package:food_app/screens/home/components/sectionTitle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int unreadNotificationCount = 0; // เริ่มต้นที่ 0

  @override
  void initState() {
    super.initState();
    setState(() {
      unreadNotificationCount = cartItems.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // แถบบนจอ
          SliverAppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: defaultPadding / 2),
                child: IconButton(
                  icon: Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(cartItems: cartItems),
                      ),
                    );
                  },
                ),
              ),
            ],
            centerTitle: true,
            backgroundColor: kMainColor,
            elevation: 0,
            floating: true,
            pinned: true,
            title: Column(
              children: [
                Text(
                  'NOOMNIM'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          // ภาพใหญ่
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: ImageCarouselWithDots(),
            ),
          ),
          // หัวข้อ
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding / 4),
            sliver: SliverToBoxAdapter(
              child: sectionTitle(
                title: 'เมนูแนะนำ',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuScreen()),
                  );
                },
              ),
            ),
          ),
          // รายการอาหาร
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                      menu.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            child: cardInfo(
                              title: menu[index].title,
                              price: menu[index].price,
                              image: menu[index].image,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodDetailsScreen(
                                            food: menu[index])));
                              },
                            ),
                          ))),
            ),
          ),
          // ตั๋ว
          SliverPadding(
            padding: const EdgeInsets.all(defaultPadding),
            sliver: SliverToBoxAdapter(
              child: Image.asset('assets/images/Banner.png'),
            ),
          ),
        ],
      ),
    );
  }
}
