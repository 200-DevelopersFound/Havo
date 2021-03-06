import 'dart:convert';
import 'dart:io';
import 'package:havo/constants/api.dart';
import 'package:havo/model/User.dart';
import 'package:havo/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryApi {
  static late List<Category> categoryList;
  static void CategoryApiInit() {
    categoryList = [];
  }

  static List<Category> getDummy() {
    for (int i = 0; i < 10; i++)
      categoryList
          .add(Category(id: i.toString(), title: "String$i", dialogues: [
        "See your saved message and lets you easily convert into voice$i 1",
        "String$i 2"
      ]));
    return categoryList;
  }

  static Future<List<Category>> getCategory() async {
    final response = await http.post(
      Uri.parse(api + '/user/category/get'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + User.logintoken,
      },
      body: jsonEncode(<String, String>{}),
    );
    if (response.statusCode == 200) {
      var x = jsonDecode(response.body);
      print("token" + response.body);
      categoryList = Category.allCategoryFromJson(response.body);
      return categoryList;
    } else {
      var x = jsonDecode(response.body);

      return x;
    }
  }

  static Future<bool> addCategory(String title) async {
    final response = await http.post(
      Uri.parse(api + '/user/category/create/category'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + User.logintoken,
      },
      body: jsonEncode(<String, String>{
        'categoryName': title,
      }),
    );

    if (response.statusCode == 201) {
      var x = jsonDecode(response.body);
      print("key:" + x.toString());
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateCategory(String dialogue, String id) async {
    final response = await http.post(
      Uri.parse(api + '/user/category/update/dialogue'),
      headers: <String, String>{
        HttpHeaders.authorizationHeader: 'Bearer ' + User.logintoken,
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String, String>{'categoryId': id, 'dialogue': dialogue}),
    );
    print(response.body);
    print('statusCode');
    print(response.statusCode);
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // id=""->,otp from email,email
      var x = jsonDecode(response.body);
      return true;
      // return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return false;
      // throw Exception('Failed to get OTP.');
    }
  }
}
