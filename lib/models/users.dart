import 'dart:convert';
import 'package:food_app/utils/getToken.dart';
import 'package:http/http.dart' as http;

class Account {
  final String email, password;

  Account({required this.email, required this.password});
}

class Profile {
  final Account account;
  final String username, firstname, lastname, birthday;
  Profile(
      {required this.account,
      required this.username,
      required this.firstname,
      required this.lastname,
      required this.birthday});
}

class User {
  final Account account;
  final Profile profile;
  User({required this.account, required this.profile});
}

List<dynamic> profile = [];

Future<List<dynamic>> getProfile() async {
  final token = await getToken();
  final response = await http.get(
    Uri.parse('http://192.168.1.84:3333/user/get'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type':
          'application/json', // อาจจะต้องปรับแต่งตามความต้องการของ API
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data;
  } else {
    // กรณีเกิดข้อผิดพลาดในการรับข้อมูล
    return [];
  }
}

Future<void> convertProfile() async {
  final data = await getProfile();
  profile = data.map((data) {
    List<int> imageData = (data['image']['data'] as List).cast<int>();

    return {
      'image': imageData,
      'username': data['username'],
      'firstname': data['firstname'],
      'lastname': data['lastname'],
      'phonenumber': data['phonenumber'],
      'birthday': data['birthday'],
    };
  }).toList();
}
