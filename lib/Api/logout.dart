import 'package:learning_digital_ink_recognition_example/constants/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> logout(String email, String otp, String verificationKey) async {
  print("custom" + verificationKey);
  final response = await http.post(
    Uri.parse(api + '/email/logout'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{}),
  );
  print(response.body);
  if (response.statusCode == 200) {
    var x = jsonDecode(response.body);
    if (x['status'] == "SUCCESS")
      return true;
    else
      return false;
  } else {
    return false;
  }
}
