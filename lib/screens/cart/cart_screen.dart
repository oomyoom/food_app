import 'package:flutter/material.dart';
import 'package:food_app/screens/cart/components/deliveryOption.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/screens/cart/components/foodcartContainer.dart';
import 'package:food_app/models/order.dart';
import 'package:food_app/utils/tapButton.dart';
import 'package:food_app/utils/stripeService.dart';

class CartItem {
  final Menu foodItem;
  double priceItem, specfiyPrice;
  String specifyItem;
  int quantity;

  CartItem(
      {required this.foodItem,
      required this.quantity,
      required this.priceItem,
      required this.specifyItem,
      required this.specfiyPrice});
}

final List<CartItem> cartItems = [];
double totalPrice = 0, serviceCharge = 0;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required List<CartItem> cartItems})
      : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kMainColor,
          elevation: 0,
          title: Text(
            'My Cart'.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        body: Center(
          child: Text(
            'Your cart is empty',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black45),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kMainColor,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'My Cart'.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    const FoodcartContainer(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                      child: Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black26, width: 1))),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: DeliveryOption(),
                    )
                  ],
                ),
              )),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: kMainColor,
              child: TapButton(
                press: () async {
                  await StripeService.stripePaymentCheckout(
                      cartItems, totalPrice, context, mounted, onSuccess: () {
                    orderId++;

                    final newOrder = Order(
                      orderId: orderId,
                      orderItems: List.from(cartItems),
                      totalPrice: totalPrice,
                      creatDateTime: DateTime.now(),
                      deliveryOption: deliveryTextOption,
                    );

                    order.add(newOrder);

                    cartItems.clear();
                    totalPrice = 0;
                    Navigator.pop(context);
                  }, onCancel: () {
                    print('Cancel');
                  }, onError: (e) {
                    print('Error: ' + e.toString());
                  });
                },
                title: 'Checkout',
                color: kMainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
