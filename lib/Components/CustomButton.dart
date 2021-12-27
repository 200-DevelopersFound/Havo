import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_loading_button/progress_loading_button.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function()? onTap;
  const CustomButton({
    Key? key,
    required this.text,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //       padding: EdgeInsets.symmetric(vertical: 16),
    //       decoration: BoxDecoration(
    //         color: Color(0xffEB532B),
    //         borderRadius: BorderRadius.circular(15),
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(
    //             text,
    //             style: TextStyle(
    //                 color: Colors.white,
    //                 fontSize: 16,
    //                 fontWeight: FontWeight.w500),
    //           ),
    //           Visibility(
    //             visible: icon != null,
    //             child: Icon(
    //               icon,
    //               size: 20,
    //               color: Colors.white,
    //             ),
    //           ),
    //         ],
    //       )),
    // );
    return LoadingButton(
      defaultWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Visibility(
            visible: icon != null,
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
      borderRadius: 18,
      height: 50,
      color: Color(0xffEB532B),
      loadingWidget: CircularProgressIndicator(
        color: Colors.white,
      ),
      onPressed: onTap,
    );
  }
}
