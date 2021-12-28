import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_digital_ink_recognition_example/constants/api.dart';

Future<bool> emailVerify(
    String email, String otp, String verificationKey) async {
  print("custom" + verificationKey);
  final response = await http.post(
    Uri.parse(api + '/email/verify/otp'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'verification_key': verificationKey,
      'otp': otp,
      "check": email
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    var x = jsonDecode(response.body);
    print("key:" + x.toString());
    if (x['status'] == "SUCCESS")
      return true;
    else
      return false;
  } else {
    return false;
  }
}
