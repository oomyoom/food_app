import 'package:food_app/screens/cart/cart_screen.dart';

class OrderQueue {
  bool isCompleted = false;

  int OrderId = orderId;
  final List<CartItem> cartItems;
  final List<double> priceItems;
  final List<String> specifyItems;
  final double totalPrice;

  OrderQueue(
      {required this.cartItems,
      required this.priceItems,
      required this.specifyItems,
      required this.totalPrice});
}
