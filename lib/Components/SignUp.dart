import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition_example/Api/CreateUser.dart';
import 'package:learning_digital_ink_recognition_example/Api/EmailOtp.dart';
import 'package:learning_digital_ink_recognition_example/Api/EmailVerify.dart';
import 'package:learning_digital_ink_recognition_example/model/User.dart';
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
  String id = "";
  bool IsVerify = false;
  Color? color;
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
                          child: CustomTextField(
                            controller: fnameController,
                            isPasswordField: false,
                          ),
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
                          child: CustomTextField(
                            controller: lnameController,
                            isPasswordField: false,
                          ),
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
                CustomTextField(
                  controller: usernameController,
                  isPasswordField: false,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: label(
                    text: 'Password',
                  ),
                ),
                CustomTextField(
                  controller: passwordController,
                  isPasswordField: false,
                ),
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 20),
                  child: CustomButton(
                    text: "Sign up",
                    onTap: () async {
                      await createUser(
                              fnameController.text,
                              lnameController.text,
                              usernameController.text,
                              emailController.text,
                              passwordController.text)
                          .then((value) {
                        if (value != "error") {
                          User.UserCreate(usernameController.text,
                              emailController.text, value);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                      });
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
                CustomTextField(
                  controller: emailController,
                  isPasswordField: false,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  icon: Icons.arrow_forward,
                  text: 'Get OTP',
                  onTap: () async {
                    await getOTP(emailController.text).then((value) {
                      print("here:" + value);
                      id = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                label(
                  text: 'OTP',
                  icon: CupertinoIcons.at_circle,
                  color: color,
                ),
                CustomTextField(
                  controller: otpController,
                  isPasswordField: false,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  icon: Icons.arrow_forward,
                  text: 'Verify',
                  onTap: () async {
                    await emailVerify(emailController.text, otpController.text,
                            id.toString())
                        .then((value) {
                      setState(() {
                        if (value == false) color = Colors.red;
                        IsVerify = value;
                      });
                      return value;
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
