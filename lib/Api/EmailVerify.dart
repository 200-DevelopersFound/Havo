import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_digital_ink_recognition_example/constants/api.dart';

Future<bool> emailVerify(
    String email, String otp, String verificationKey) async {
  final response = await http.post(
    Uri.parse(api + '/email/verify/otp'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'verificationKey': verificationKey,
      'otp': otp,
      "check": email
    }),
  );

  if (response.statusCode == 200) {
    var x = jsonDecode(response.body);
    print("key:" + x.toString());
    if (x['Status'] == "Success")
      return true;
    else
      return false;
  } else {
    throw Exception('Failed to verify email.');
  }
}
