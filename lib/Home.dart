import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition_example/constants/colors.dart';

import 'Components/BlurredCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [darkBlack, lightBlack])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi User!',
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/women/' +
                            Random().nextInt(100).toString() +
                            '.jpg'),
                  )
                ],
              ),
              BlurredCard(
                heading: 'Drawing board',
                subheading:
                    "Let's you write in the drawing board and convert your text into voice",
                icon: Icons.gesture,
              ),
              BlurredCard(
                heading: 'Saved',
                subheading:
                    "See your saved message and lets you easily convert into voice",
                icon: Icons.list_alt_outlined,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
