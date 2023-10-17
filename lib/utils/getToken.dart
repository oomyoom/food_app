import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}

void printToken() async {
  final token = await getToken();
  if (token != null) {
    print('Token: $token');
  } else {
    print('Token not found');
  }
}
