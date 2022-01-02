import 'dart:convert';
import 'package:havo/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:havo/constants/api.dart';

Future<String> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse(api + '/user/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"email": email, "password": password}),
  );
  print(response.body);
  if (response.statusCode == 200) {
    var x = jsonDecode(response.body);
    print(response.body);
    if (x['auth'] == true) {
      User.UserCreate(x['user']['username'], x['user']['email'], x['token'],
          x['user']['firstName'], x['user']['lastName']);
      return x['token'];
    } else
      return "error";
  } else {
    return "error";
  }
}
