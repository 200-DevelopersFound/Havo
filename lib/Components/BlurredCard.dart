import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition_example/constants/colors.dart';

class BlurredCard extends StatefulWidget {
  String heading, subheading;
  IconData icon;
  BlurredCard(
      {Key? key,
      required this.heading,
      required this.subheading,
      required this.icon})
      : super(key: key);

  @override
  _BlurredCardState createState() => _BlurredCardState();
}

class _BlurredCardState extends State<BlurredCard> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 300,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [orange, Colors.pink])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.heading,
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  widget.icon,
                  color: Colors.white,
                  size: 100,
                ),
              ],
            ),
            Text(
              widget.subheading,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
