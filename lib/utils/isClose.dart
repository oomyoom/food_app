import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

List<dynamic> restaurant = [];

Future<List<dynamic>> getisClose() async {
  final response = await http.get(
    Uri.parse('http://192.168.1.84:3333/restaurant/get'),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> isClose = json.decode(response.body);
    return isClose;
  } else {
    // กรณีเกิดข้อผิดพลาดในการรับข้อมูล
    return [];
  }
}

Future<void> isClose() async {
  List<dynamic> isCloseData = await getisClose(); // รอให้ Future ทำงานเสร็จ
  restaurant = isCloseData;
}
