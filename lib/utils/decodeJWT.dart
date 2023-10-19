import 'dart:convert';
import 'package:food_app/utils/getToken.dart';

String base64UrlDecode(String input) {
  String base64 = input.replaceAll('-', '+').replaceAll('_', '/');
  while (base64.length % 4 != 0) {
    base64 += '=';
  }
  return utf8.decode(base64Decode(base64));
}

Map<String, dynamic> decodeJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw const FormatException('Invalid token');
  }

  final payload = parts[1];
  final decoded = base64UrlDecode(payload);

  return json.decode(decoded);
}

void decodedToken() async {
  final token =
      await getToken(); // แทน YOUR_JWT_TOKEN_HERE ด้วยโทเคน JWT ที่คุณต้องการถอดรหัส

  final decodedToken = decodeJwt(token!);
  print(decodedToken);
}
