import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:learning_digital_ink_recognition_example/Components/SignUp.dart';

import '../Components/SignIn.dart';
import '../constants/colors.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [darkBlack, lightBlack])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Havo',
                      style: TextStyle(fontSize: 40, color: orange),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width,
                    // padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        color: Color(0xff1B2127),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 60,
                          child: TabBar(
                              indicatorColor: orange,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.grey[600],
                              tabs: [
                                Tab(
                                  child: Text(
                                    'Sign in',
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Sign up',
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [SignIn(), SignUp()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
