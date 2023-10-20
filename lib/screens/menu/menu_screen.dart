import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/screens/menu/components/menuInfo.dart';
import 'package:food_app/screens/menu/food_details_screen.dart';
import 'package:food_app/models/foodData.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // แถบบนจอ
          SliverAppBar(
            centerTitle: true,
            backgroundColor: kMainColor,
            elevation: 0,
            floating: true,
            title: Column(
              children: [
                Text(
                  'เมนู'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          // รายการอาหาร
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                        children: List.generate(
                            menu.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding / 2),
                                  child: MenuInfo(
                                    title: menu[index].title,
                                    image: menu[index].image,
                                    price: menu[index].price,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FoodDetailsScreen(
                                                  food: menu[index],
                                                )),
                                      );
                                    },
                                  ),
                                ))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
