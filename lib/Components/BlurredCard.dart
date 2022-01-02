import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:havo/constants/colors.dart';

class BlurredCard extends StatefulWidget {
  String heading, subheading;
  IconData icon;
  Function()? onTap;
  BlurredCard(
      {Key? key,
      required this.heading,
      required this.subheading,
      required this.icon,
      required this.onTap})
      : super(key: key);

  @override
  _BlurredCardState createState() => _BlurredCardState();
}

class _BlurredCardState extends State<BlurredCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 170,
          width: 275,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [orange, Colors.pink]),
              color: orange),
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
                    style: GoogleFonts.oswald(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.subheading,
                style: GoogleFonts.oswald(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
