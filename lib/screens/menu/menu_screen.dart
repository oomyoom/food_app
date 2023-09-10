import 'package:flutter/material.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/screens/menu/components/menuInfo.dart';
import 'package:food_app/screens/menu/food_details_screen.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/screens/cart/cart_screen.dart';

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
            backgroundColor: Color.fromARGB(255, 66, 118, 93),
            elevation: 0,
            floating: true,
            title: Column(
              children: [
                Text(
                  'Menu'.toUpperCase(),
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
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                        children: List.generate(
                            demoMediumCardData.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding / 2),
                                  child: MenuInfo(
                                    title: demoMediumCardData[index].title,
                                    image: demoMediumCardData[index].image,
                                    price: demoMediumCardData[index].price,
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FoodDetailsScreen(
                                                  food:
                                                      demoMediumCardData[index],
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
