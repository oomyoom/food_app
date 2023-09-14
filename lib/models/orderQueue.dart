import 'package:food_app/screens/cart/cart_screen.dart';

class OrderQueue {
  bool isCompleted = false;

  int OrderId = orderId;
  final List<CartItem> cartItems;
  final double totalPrice;

  OrderQueue({required this.cartItems, required this.totalPrice});
}
