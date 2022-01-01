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
  bool emailCheck = false,
      psdCheck = false,
      otpCheck = false,
      fnameCheck = false,
      lnameCheck = false,
      unameCheck = false;

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
                            update: (s) {
                              setState(() {
                                if (s != '')
                                  fnameCheck = true;
                                else
                                  fnameCheck = false;
                              });
                            },
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
                            update: (s) {
                              setState(() {
                                if (s != '')
                                  lnameCheck = true;
                                else
                                  lnameCheck = false;
                              });
                            },
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
                  update: (s) {
                    setState(() {
                      if (s != '')
                        unameCheck = true;
                      else
                        unameCheck = false;
                    });
                  },
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
                  update: (s) {
                    setState(() {
                      if (s != '')
                        psdCheck = true;
                      else
                        psdCheck = false;
                    });
                  },
                ),
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 20),
                  child: CustomButton(
                    text: "Sign up",
                    enable: fnameCheck && lnameCheck && unameCheck && psdCheck,
                    onTap: () async {
                      await createUser(
                              fnameController.text,
                              lnameController.text,
                              usernameController.text,
                              emailController.text,
                              passwordController.text)
                          .then((value) {
                        if (value != "error") {
                          User.UserCreate(
                              usernameController.text,
                              emailController.text,
                              value,
                              fnameController.text,
                              lnameController.text);
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
                  update: (s) {
                    setState(() {
                      if (s != '')
                        emailCheck = true;
                      else
                        emailCheck = false;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  icon: Icons.arrow_forward,
                  text: 'Get OTP',
                  enable: emailCheck,
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
                  update: (s) {
                    setState(() {
                      if (otpController.text != '')
                        otpCheck = true;
                      else
                        otpCheck = false;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  icon: Icons.arrow_forward,
                  text: 'Verify',
                  enable: otpCheck,
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
