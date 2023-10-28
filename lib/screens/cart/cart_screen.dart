import 'package:flutter/material.dart';
import 'package:food_app/models/cart.dart';
import 'package:food_app/screens/cart/components/deliveryOption.dart';
import 'package:food_app/screens/receipt/receipt_screen.dart';
import 'package:food_app/utils/buttomTab.dart';
import 'package:food_app/utils/constants.dart';
import 'package:food_app/models/foodData.dart';
import 'package:food_app/screens/cart/components/foodcartContainer.dart';
import 'package:food_app/models/order.dart';
import 'package:food_app/utils/getToken.dart';
import 'package:food_app/utils/tapButton.dart';
import 'package:food_app/utils/stripeService.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartItem {
  final Menu2 foodItem;
  int priceItem, specfiyPrice;
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
int totalPrice = 0;

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required List<CartItem> cartItems})
      : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future<void> sendOrder() async {
    final token = await getToken();
    await convertCartItems();
    await convertOrder();

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.84:3333/order/create'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'cartData': cartData,
          'orderData': orderData[0],
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('สร้างออเดอร์สำเร็จ'),
            duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
          ),
        );
        await convertAllOrder();

        cartItems.clear();
        order.clear();
        totalPrice = 0;
        while (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ButtomTab(initialIndex: 0)));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReceiptScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('สร้างออเดอร์ล้มเหลว'),
            duration: Duration(seconds: 3), // ระยะเวลาที่แจ้งเตือนแสดง
          ),
        );
      }
    } catch (e) {
      // เกิดข้อผิดพลาดในการส่งข้อมูล
      print('เกิดข้อผิดพลาด: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kMainColor,
          elevation: 0,
          title: Text(
            'ตะกร้าของฉัน'.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
          ),
        ),
        body: Center(
          child: Text(
            'ตะกร้าของคุณว่าง',
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
              'ตะกร้าของฉัน'.toUpperCase(),
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
                  List<CartItem> tempcartItems = List.from(cartItems);
                  tempcartItems.add(CartItem(
                      foodItem: Menu2(
                          id: 0,
                          title: 'Service Charge',
                          image: [1],
                          price: 5,
                          categories: [
                            FoodCategory2(
                                categorytitle: ' ',
                                optiontitle: [' '],
                                optionprice: [0])
                          ]),
                      quantity: 1,
                      priceItem: 5,
                      specifyItem: ' ',
                      specfiyPrice: 0));
                  await StripeService.stripePaymentCheckout(
                      tempcartItems, totalPrice, context, mounted,
                      onSuccess: () async {
                    orderId++;

                    final newOrder = Order(
                      orderId: orderId,
                      orderItems: List.from(cartItems),
                      totalPrice: totalPrice,
                      creatDateTime: DateTime.now(),
                      deliveryOption: deliveryTextOption,
                    );

                    order.add(newOrder);
                    await sendOrder();
                  }, onCancel: () {
                    print('Cancel');
                  }, onError: (e) {
                    print('Error: $e');
                  });
                },
                title: 'เช็คเอาท์',
                color: kMainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
