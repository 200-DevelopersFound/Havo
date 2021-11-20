import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  child: CustomTextField(controller: emailController),
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
                  child: CustomTextField(controller: emailController),
                ),
              ],
            )
          ],
        ),
        // CustomTextField(controller: emailController),
        SizedBox(
          height: 20,
        ),
        label(
          text: 'OTP',
          icon: CupertinoIcons.at_circle,
        ),
        CustomTextField(controller: emailController),
        SizedBox(
          height: 20,
        ),
        CustomButton(
          icon: Icons.arrow_forward,
          text: 'Verify',
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          },
        ),
      ],
    );
  }
}
