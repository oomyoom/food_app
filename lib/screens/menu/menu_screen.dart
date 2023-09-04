import 'package:flutter/material.dart';
import 'package:food_app/constants.dart';
import 'package:food_app/demoData.dart';
import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/screens/home/components/cardInfo.dart';

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
          SliverAppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // ไปยังหน้าตะกร้าสินค้า
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: cartItems),
                    ),
                  );
                },
              ),
            ],
            automaticallyImplyLeading: false,
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
          SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            sliver: SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                        children: List.generate(
                            demoMediumCardData.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding / 2),
                                  child: cardInfo(
                                    title: demoMediumCardData[index].title,
                                    location:
                                        demoMediumCardData[index].location,
                                    image: demoMediumCardData[index].image,
                                    delivertTime:
                                        demoMediumCardData[index].delivertTime,
                                    rating: demoMediumCardData[index].rating,
                                    press: () {
                                      cartItems.add(CartItem(
                                          foodItem: demoMediumCardData[index]));
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
