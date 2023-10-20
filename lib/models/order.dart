import 'package:food_app/screens/cart/cart_screen.dart';

final List<Order> order = [];
int orderId = 0;

class Order {
  bool isCompleted = false;

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
      required this.deliveryOption});
}
