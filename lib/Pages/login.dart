import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_digital_ink_recognition_example/Components/SignUp.dart';

import '../Components/SignIn.dart';
import '../constants/colors.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int tabCheck = 0;
  bool emailCheck = false, psdCheck = false, otpcheck = false;
  @override
  void initState() {
    tabController = new TabController(vsync: this, length: 2, initialIndex: 0);
    print("here1:" + tabController.indexIsChanging.toString());
    tabController.animation?.addListener(() {
      if (tabController.indexIsChanging) {
        setState(() {
          tabCheck = tabController.index;
          print("changing");
        });
      } else if (tabController.offset > 0.5)
        setState(() {
          print("1called");
          tabCheck = 1;
        });
      else if (tabController.offset < -0.5)
        setState(() {
          print("0called");
          tabCheck = 0;
        });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [darkBlack, lightBlack])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 150,
                  height: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: orange, width: 10),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    'Havo',
                    style: GoogleFonts.pacifico(fontSize: 40, color: orange),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xff1B2127),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.white))),
                          child: TabBar(
                              controller: tabController,
                              indicatorColor: orange,
                              labelColor: Colors.white,
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              unselectedLabelColor: Colors.grey[600],
                              indicator: BoxDecoration(
                                color: orange,
                                borderRadius: BorderRadius.only(
                                  topLeft: tabCheck == 0
                                      ? Radius.circular(40)
                                      : Radius.zero,
                                  topRight: tabCheck == 1
                                      ? Radius.circular(40)
                                      : Radius.zero,
                                ),
                              ),
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
                            controller: tabController,
                            children: [
                              AnimatedBuilder(
                                animation: tabController.animation!,
                                builder: (BuildContext context, snapshot) {
                                  return Opacity(
                                    opacity: 1 - tabController.animation!.value,
                                    child: SignIn(),
                                  );
                                },
                              ),
                              AnimatedBuilder(
                                animation: tabController.animation!,
                                builder: (BuildContext context, snapshot) {
                                  return Opacity(
                                    opacity: tabController.animation!.value,
                                    child: SignUp(),
                                  );
                                },
                              ),
                            ],
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
