import 'dart:io';

import 'package:learning_digital_ink_recognition_example/constants/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_digital_ink_recognition_example/model/User.dart';

Future<bool> logout() async {
  final response = await http.delete(
    Uri.parse(api + '/user/logout'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ' + User.logintoken,
    },
    body: jsonEncode(<String, String>{}),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
