// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/screens/home/components/imageCarousel.dart';
import 'package:food_app/screens/menu/food_details_screen.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/screens/menu/menu_screen.dart';
import 'package:food_app/screens/home/components/cardInfo.dart';
import 'package:food_app/screens/home/components/sectionTitle.dart';
import 'package:food_app/screens/sign/login_screen.dart';
import 'package:food_app/screens/sign/profilecreation_screen.dart';
import 'package:food_app/screens/sign/register_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  icon: Icon(Icons.shopping_cart),
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
                  'PWO Restaurant'.toUpperCase(),
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
                title: 'Featured Partners',
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
                      demoMediumCardData.length,
                      (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding / 2),
                            child: cardInfo(
                              title: demoMediumCardData[index].title,
                              price: demoMediumCardData[index].price,
                              image: demoMediumCardData[index].image,
                              press: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodDetailsScreen(
                                            food: demoMediumCardData[index])));
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
      // Shortcut
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.black,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 10,
        children: [
          SpeedDialChild(
            child: Icon(Icons.login_rounded),
            backgroundColor: Colors.blueAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.app_registration),
            backgroundColor: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add_shopping_cart),
            backgroundColor: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MenuScreen()),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.usb_rounded),
            backgroundColor: Colors.redAccent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfilecreationScreen()),
              );
            },
          )
        ],
      ),
    );
  }
}
