import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class label extends StatelessWidget {
  final String text;
  IconData? icon;
  Color? color;

  label({
    Key? key,
    required this.text,
    this.icon,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: color != null ? color : Colors.grey,
              size: 20,
            ),
          if (icon != null)
            SizedBox(
              width: 8,
            ),
          Text(text,
              style: TextStyle(
                  color: color != null ? color : Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
