import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition_example/model/User.dart';
import 'package:learning_digital_ink_recognition_example/Api/loginUser.dart';
import 'package:learning_digital_ink_recognition_example/Pages/Home.dart';
import 'package:learning_digital_ink_recognition_example/Pages/login.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        label(
          icon: CupertinoIcons.mail,
          text: 'Email',
          color: color,
        ),
        CustomTextField(
          controller: emailController,
          isPasswordField: false,
        ),
        SizedBox(
          height: 20,
        ),
        label(icon: CupertinoIcons.lock, color: color, text: 'Password'),
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
          onTap: () async {
            await loginUser(emailController.text, passwordController.text)
                .then((value) {
              if (value != "error") {
                User.UserLogin(emailController.text, value);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              } else
                setState(() {
                  color = Colors.red;
                });
            });
            // Navigator.push(context, MaterialPageRoute(
            //   builder: (BuildContext context) {
            //     return HomeScreen();
            //   },
            // ));
          },
        ),
      ]),
    );
  }
}
