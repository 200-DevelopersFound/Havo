import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Future<String>? _futureId;
  Future<bool>? _futureIsVerify;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                return value;
              });
            },
          ),

          // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //           margin: EdgeInsets.only(left: 5),
          //           child: label(
          //             text: 'First Name',
          //           ),
          //         ),
          //         Container(
          //           width: MediaQuery.of(context).size.width * 0.5 - 20,
          //           child: CustomTextField(controller: emailController),
          //         ),
          //       ],
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Container(
          //           padding: EdgeInsets.only(left: 5),
          //           child: label(
          //             text: 'Last Name',
          //           ),
          //         ),
          //         Container(
          //           width: MediaQuery.of(context).size.width * 0.5 - 20,
          //           child: CustomTextField(controller: emailController),
          //         ),
          //       ],
          //     )
          //   ],
          // ),
          // CustomTextField(controller: emailController),
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
              emailVerify(emailController.text, otpController.text,
                  _futureId.toString());

              // Navigator.pushReplacement(
              //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
        ],
      ),
    );
  }
}
