// It contains all our demo data that we used

class Menu {
  final String title, image, location;
  final double price, rating;
  final int delivertTime;
  final List<FoodCategory> specifytitle;

  Menu(
      {required this.title,
      required this.image,
      required this.price,
      required this.location,
      required this.delivertTime,
      required this.rating,
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
      location: "Colarodo, San Francisco",
      rating: 4.5,
      delivertTime: 30,
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
      location: "Colarodo, San Francisco",
      rating: 4.3,
      delivertTime: 30,
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
      location: "Colarodo, San Francisco",
      rating: 4.8,
      delivertTime: 25,
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
      location: "Colarodo, San Francisco",
      rating: 4.6,
      delivertTime: 25,
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
