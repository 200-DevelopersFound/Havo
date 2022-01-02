import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:havo/Api/loginUser.dart';
import 'package:havo/Pages/Home.dart';
import 'package:havo/model/User.dart';
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
  bool emailCheck = false, psdCheck = false;
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
            update: (s) {
              setState(() {
                setState(() {
                  if (s != '')
                    emailCheck = true;
                  else
                    emailCheck = false;
                });
              });
            }),
        SizedBox(
          height: 20,
        ),
        label(icon: CupertinoIcons.lock, color: color, text: 'Password'),
        CustomTextField(
            controller: passwordController,
            isPasswordField: true,
            update: (s) {
              setState(() {
                if (s != '')
                  psdCheck = true;
                else
                  psdCheck = false;
              });
            }),
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
          enable: psdCheck && emailCheck,
          onTap: () async {
            print(passwordController.text);
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
