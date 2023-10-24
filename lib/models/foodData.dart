// It contains all our demo data that we used
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> getAllMenu() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.84:3333/menu/get/user'));

  if (response.statusCode == 200) {
    List<dynamic> allMenu = json.decode(response.body);
    return allMenu;
  } else {
    // กรณีเกิดข้อผิดพลาดในการรับข้อมูล
    return [];
  }
}

Future<void> convertAllMenu() async {
  final allMenu = await getAllMenu();
  menu = allMenu.map((data) {
    List<Map<String, dynamic>> categoriesData =
        (data['categories'] as List).cast<Map<String, dynamic>>();

    // สร้าง List ของ FoodCategory2 จาก categoriesData
    List<FoodCategory2> categories = categoriesData.map((categoryData) {
      // ดึงข้อมูลจาก categoryData
      String categoryTitle = categoryData['category_title'];
      List<String> optionTitles = (categoryData['options'] as List)
          .map((optionData) => optionData['option_title'] as String)
          .toList();
      List<int> optionPrices = (categoryData['options'] as List)
          .map((optionData) => optionData['option_price'] as int)
          .toList();

      // สร้าง instance ของ FoodCategory2
      return FoodCategory2(
        categorytitle: categoryTitle,
        optiontitle: optionTitles,
        optionprice: optionPrices,
      );
    }).toList();

    List<int> imageData = (data['menu_image']['data'] as List).cast<int>();

    return Menu2(
      id: data['menu_id'],
      title: data['menu_title'],
      image: imageData,
      price: data['menu_price'],
      categories: categories,
    );
  }).toList();
}

List<dynamic> menu = [];

class Menu2 {
  final int id;
  final String title;
  final List<int> image;
  final int price;

  final List<FoodCategory2> categories;

  Menu2(
      {required this.id,
      required this.title,
      required this.image,
      required this.price,
      required this.categories});
}

class FoodCategory2 {
  final String categorytitle;
  final List<String> optiontitle;
  final List<int> optionprice;

  FoodCategory2(
      {required this.categorytitle,
      required this.optiontitle,
      required this.optionprice});
}

class Menu {
  final String title, image;
  final double price;

  final List<FoodCategory> specifytitle;

  Menu(
      {required this.title,
      required this.image,
      required this.price,
      required this.specifytitle});
}

class FoodCategory {
  final String title;
  final List<String> specifytitle;
  final List<double> price;

  FoodCategory(
      {required this.title, required this.specifytitle, required this.price});
}

List<String> demoBigImages = [
  "assets/images/big_1.png",
  "assets/images/big_2.png",
  "assets/images/big_3.png",
  "assets/images/big_4.png",
];

List demoMediumCardData = [
  Menu(
      title: "Daylight Coffee",
      image: "assets/images/medium_1.png",
      price: 3,
      specifytitle: [
        FoodCategory(
            title: 'Special',
            specifytitle: ['Normal', 'Special'],
            price: [0.0, 10.0]),
        FoodCategory(
            title: 'Egg',
            specifytitle: ['Fried Egg', 'Star Egg'],
            price: [10.0, 10.0])
      ]),
  Menu(
      title: "Mario Italiano",
      image: "assets/images/medium_2.png",
      price: 6,
      specifytitle: [
        FoodCategory(
            title: 'Special',
            specifytitle: ['Normal', 'Special'],
            price: [0.0, 10.0]),
        FoodCategory(
            title: 'Egg',
            specifytitle: ['Fried Egg', 'Star Egg'],
            price: [10.0, 10.0])
      ]),
  Menu(
      title: "McDonald’s",
      image: "assets/images/medium_3.png",
      price: 5,
      specifytitle: [
        FoodCategory(
            title: 'Special',
            specifytitle: ['Normal', 'Special'],
            price: [0.0, 10.0]),
        FoodCategory(
            title: 'Egg',
            specifytitle: ['Fried Egg', 'Star Egg'],
            price: [10.0, 10.0])
      ]),
  Menu(
      title: "The Halal Guys",
      image: "assets/images/medium_4.png",
      price: 10,
      specifytitle: [
        FoodCategory(
            title: 'Special',
            specifytitle: ['Normal', 'Special'],
            price: [0.0, 10.0]),
        FoodCategory(
            title: 'Egg',
            specifytitle: ['Fried Egg', 'Star Egg'],
            price: [10.0, 10.0])
      ]),
];
