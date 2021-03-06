import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  bool isPasswordField;
  double? height;
  Function(String)? update;
  CustomTextField({
    required this.controller,
    required this.isPasswordField,
    this.height,
    this.update,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  IconData icon = CupertinoIcons.eye_slash_fill;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextField(
        onChanged: widget.update != null ? widget.update : (s) {},
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: widget.height != null ? widget.height : 18,
            fontWeight: FontWeight.w400),
        cursorColor: Color(0xffffffff),
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: Color(0xff2D3337),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          suffixIcon: widget.isPasswordField == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      if (icon == CupertinoIcons.eye_fill)
                        icon = CupertinoIcons.eye_slash_fill;
                      else
                        icon = CupertinoIcons.eye_fill;
                    });
                  },
                  child: Icon(
                    icon,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
        obscureText:
            widget.isPasswordField && icon == CupertinoIcons.eye_slash_fill,
      ),
    );
  }
}
