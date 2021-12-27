import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_digital_ink_recognition_example/constants/api.dart';
import 'package:learning_digital_ink_recognition_example/model/category.dart';

class CategoryApi {
  static late List<Category> categoryList;
  static void CategoryApiInit() {
    categoryList = [];
  }

  static List<Category> getDummy() {
    for (int i = 0; i < 10; i++)
      categoryList.add(Category(i.toString(), "String$i", [
        "See your saved message and lets you easily convert into voice$i 1",
        "String$i 2"
      ]));
    return categoryList;
  }

  static Future<String> getCategory(String token) async {
    final response = await http.post(
      Uri.parse(api + '/user/category/get'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'token': token,
      }),
    );
    if (response.statusCode == 200) {
      var x = jsonDecode(response.body);
      print("token" + response.body);
      return x['dialogues'];
    } else {
      return "error";
    }
  }

  static Future<String> addCategory(String email) async {
    final response = await http.post(
      Uri.parse(api + '/user/category/create/category'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      var x = jsonDecode(response.body);
      print("key:" + x.toString());
      return x['verification_key'];
    } else {
      throw Exception('Failed to get OTP.');
    }
  }

  static Future<String> updateCategory(String email) async {
    final response = await http.post(
      Uri.parse(api + '/user/category/update/dialogue'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // id=""->,otp from email,email
      var x = jsonDecode(response.body);
      print("key:" + x.toString());
      return x['verification_key'];
      // return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to get OTP.');
    }
  }
}
