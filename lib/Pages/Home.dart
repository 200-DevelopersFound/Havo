import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:learning_digital_ink_recognition_example/Api/CategoryApi.dart';
import 'package:learning_digital_ink_recognition_example/Pages/savedCategory.dart';
import 'package:learning_digital_ink_recognition_example/Pages/setting.dart';
import 'package:learning_digital_ink_recognition_example/constants/colors.dart';
import 'package:progress_loading_button/progress_loading_button.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/BlurredCard.dart';
import '../Components/Ink.dart';
import 'HomeBody.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController mController = TextEditingController();
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [lightBlack, darkBlack])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: GNav(
          gap: 8,
          backgroundColor: darkBlack,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: Duration(milliseconds: 400),
          tabBackgroundColor: Colors.grey[100]!,
          color: Colors.black,
          tabs: [
            GButton(
              iconColor: orange,
              icon: CupertinoIcons.gear,
              text: 'Setting',
              backgroundColor: orange,
              textColor: Colors.white,
              iconActiveColor: Colors.white,
            ),
            GButton(
              icon: Icons.home_filled,
              text: 'Home',
              iconColor: orange,
              backgroundColor: orange,
              textColor: Colors.white,
              iconActiveColor: Colors.white,
            ),
            GButton(
              iconColor: orange,
              icon: CupertinoIcons.doc,
              text: 'Profile',
              backgroundColor: orange,
              textColor: Colors.white,
              iconActiveColor: Colors.white,
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        body: SafeArea(
          child: getBody(_selectedIndex, ScreenOrientationUpdate),
        ),
      ),
    );
  }

  void ScreenOrientationUpdate() {
    setState(() {
      // _selectedIndex = 1;
    });
  }
}

getBody(int s, Function() update) {
  if (s == 1)
    return HomeBody(screenOrientationUpdate: update);
  else if (s == 2)
    return SavedCategoryPage();
  else
    return settingPage();
}
