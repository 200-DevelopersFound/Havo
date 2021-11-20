import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CustomButton.dart';
import 'CustomTextField.dart';
import 'Ink.dart';
import 'label.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      // SizedBox(
      //   height: 50,
      // ),
      label(icon: CupertinoIcons.person, text: 'Username'),
      CustomTextField(controller: userNameController),
      SizedBox(
        height: 20,
      ),
      label(icon: CupertinoIcons.lock, text: 'Password'),
      CustomTextField(
        controller: passwordController,
        isPasswordField: true,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.only(top: 6),
          child: Text('Forgot Password?',
              style:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
        ),
      ),
      SizedBox(height: 20),
      CustomButton(
        icon: Icons.arrow_forward,
        text: 'Sign in',
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ChangeNotifierProvider(
                create: (_) => DigitalInkRecognition2State(),
                child: DigitalInkRecognitionPage2(),
              );
            },
          ));
        },
      ),
    ]);
  }
}
