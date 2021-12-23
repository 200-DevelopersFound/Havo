import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning_digital_ink_recognition_example/constants/api.dart';

Future<String> getOTP(String email) async {
  final response = await http.post(
    Uri.parse(api + '/email/otp'),
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
