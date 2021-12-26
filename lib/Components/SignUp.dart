import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition_example/Api/CreateUser.dart';
import 'package:learning_digital_ink_recognition_example/Api/EmailOtp.dart';
import 'package:learning_digital_ink_recognition_example/Api/EmailVerify.dart';
import 'package:learning_digital_ink_recognition_example/Components/CustomTextField.dart';
import 'package:learning_digital_ink_recognition_example/Pages/Home.dart';

import 'CustomButton.dart';
import 'label.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  Future<String>? _futureId;
  Future<bool>? _futureIsVerify;
  Future<String>? _futureToken;
  String id = "";
  bool IsVerify = false;
  @override
  Widget build(BuildContext context) {
    return IsVerify == true
        ? Container(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: label(
                            text: 'First Name',
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5 - 20,
                          child: CustomTextField(controller: fnameController),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: label(
                            text: 'Last Name',
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5 - 20,
                          child: CustomTextField(controller: lnameController),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: label(
                    text: 'Username',
                  ),
                ),
                CustomTextField(controller: usernameController),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: label(
                    text: 'Password',
                  ),
                ),
                CustomTextField(controller: passwordController),
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 20),
                  child: CustomButton(
                    text: "Sign up",
                    onTap: () {
                      _futureToken = createUser(
                          fnameController.text,
                          lnameController.text,
                          usernameController.text,
                          emailController.text,
                          passwordController.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    },
                  ),
                ),
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                label(
                  text: 'Email',
                  icon: CupertinoIcons.at_circle,
                ),
                CustomTextField(controller: emailController),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  icon: Icons.arrow_forward,
                  text: 'Get OTP',
                  onTap: () {
                    _futureId = getOTP(emailController.text).then((value) {
                      print("here:" + value);
                      id = value;
                      return value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                label(
                  text: 'OTP',
                  icon: CupertinoIcons.at_circle,
                ),
                CustomTextField(controller: otpController),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  icon: Icons.arrow_forward,
                  text: 'Verify',
                  onTap: () {
                    setState(() {
                      _futureIsVerify = emailVerify(emailController.text,
                              otpController.text, id.toString())
                          .then((value) {
                        setState(() {
                          IsVerify = value;
                          print("here" + IsVerify.toString());
                        });
                        return value;
                      });
                    });

                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ],
            ),
          );
  }
}
