import 'package:food_app/screens/cart/cart_screen.dart';

List<dynamic> cartData = [];

Future<void> convertCartItems() async {
  cartData = List.from(cartItems).map((e) {
    return {
      'cart_item': e.foodItem.title,
      'option_item': e.specifyItem,
      'option_total': e.specfiyPrice,
      'cart_total': e.priceItem,
      'cart_qty': e.quantity,
    };
  }).toList();
  print(cartData[0]);
}
