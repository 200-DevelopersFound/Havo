import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_digital_ink_recognition_example/constants/api.dart';

Future<String> createUser(String fname, String lname, String username,
    String email, String password) async {
  final response = await http.post(
    Uri.parse(api + '/user/create'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'fname': fname,
      'lname': lname,
      'username': username,
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // id=""->,otp from email,email
    var x = jsonDecode(response.body);
    if (x['auth'] == true)
      return x['token'];
    else
      return "error";
    // return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    return "error";
  }
}
