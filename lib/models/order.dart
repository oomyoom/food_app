import 'package:food_app/screens/cart/cart_screen.dart';
import 'package:food_app/utils/getToken.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final List<Order> order = [];
int orderId = 0;

class Order {
  bool isCompleted;
  bool isRecieved;
  bool isReaded;

  final int orderId;
  final List<CartItem> orderItems;
  final int totalPrice;
  final DateTime creatDateTime;
  final String deliveryOption;

  Order(
      {required this.orderId,
      required this.orderItems,
      required this.totalPrice,
      required this.creatDateTime,
      required this.deliveryOption,
      this.isCompleted = false,
      this.isRecieved = false,
      this.isReaded = false});
}

List<dynamic> orderData = [];
List<dynamic> orderHist = [];

Future<void> convertOrder() async {
  orderData = List.from(order).map((e) {
    return {
      'order_total': e.totalPrice,
      'createDateTime': e.creatDateTime.toString().substring(0, 19),
      'deliveryOption': e.deliveryOption,
      'isCompleted': e.isCompleted,
      'isRecieved': false,
      'isReaded': false,
    };
  }).toList();
}

Future<List<dynamic>> getAllOrder() async {
  final token = await getToken();

  final response = await http.get(
    Uri.parse('http://192.168.1.84:3333/order/get'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> allOrder = json.decode(response.body);
    return allOrder;
  } else {
    // กรณีเกิดข้อผิดพลาดในการรับข้อมูล
    return [];
  }
}

class Order2 {
  bool isCompleted;
  bool isRecieved;

  final int orderId;
  final List<CartItem2> orderItems;
  final int totalPrice;
  final DateTime creatDateTime;
  final String deliveryOption;

  Order2(
      {required this.orderId,
      required this.orderItems,
      required this.totalPrice,
      required this.creatDateTime,
      required this.deliveryOption,
      this.isCompleted = false,
      this.isRecieved = false});
}

class CartItem2 {
  final Menu3 foodItem;
  int priceItem, specfiyPrice;
  String specifyItem;
  int quantity;

  CartItem2(
      {required this.foodItem,
      required this.quantity,
      required this.priceItem,
      required this.specifyItem,
      required this.specfiyPrice});
}

class Menu3 {
  final int id;
  final String title;
  final List<int> image;
  final int price;

  Menu3({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });
}

Future<void> convertAllOrder() async {
  final allOrder = await getAllOrder();
  orderHist = allOrder.map((e) {
    List<Map<String, dynamic>> cartData =
        (e['cart'] as List).cast<Map<String, dynamic>>();

    List<CartItem2> cart = cartData.map(
      (cart) {
        String optionItem = cart['option_item'];
        int optionTotal = cart['option_total'];
        int cartTotal = cart['cart_total'];
        int cartQty = cart['cart_qty'];

        int menuId = cart['menu']['menu_id'];
        String menuTitle = cart['menu']['menu_title'];
        int menuPrice = cart['menu']['menu_price'];
        List<int> menuImage =
            (cart['menu']['menu_image']['data'] as List).cast<int>();

        return CartItem2(
            foodItem: Menu3(
              id: menuId,
              title: menuTitle,
              image: menuImage,
              price: menuPrice,
            ),
            quantity: cartQty,
            priceItem: cartTotal,
            specifyItem: optionItem,
            specfiyPrice: optionTotal);
      },
    ).toList();

    return Order2(
        orderId: e['order_id'],
        orderItems: cart,
        totalPrice: e['order_total'],
        creatDateTime: DateTime.parse(e['createDateTime']).toLocal(),
        deliveryOption: e['deliveryOption'],
        isCompleted: (e['isCompleted'] == 1),
        isRecieved: (e['isRecieved'] == 1));
  }).toList();
}
