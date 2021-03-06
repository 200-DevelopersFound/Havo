import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:havo/Api/logout.dart';
import 'package:havo/Components/ColorPicker.dart';
import 'package:havo/constants/colors.dart';
import 'package:havo/model/User.dart';
import 'package:havo/model/drawer.dart';
import 'package:image_picker/image_picker.dart';

import 'login.dart';

class settingPage extends StatefulWidget {
  const settingPage({Key? key}) : super(key: key);

  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  late TextEditingController userNameController;
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool isPasswordEditable = false;
  bool isUsernameEditable = false;
  bool isFnameEditable = false;
  bool isLnameEditable = false;
  bool isEmailEditable = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  int check = 0;
  @override
  void initState() {
    userNameController = TextEditingController(text: User.username);
    fnameController = TextEditingController(text: User.fname);
    lnameController = TextEditingController(text: User.lname);
    emailController = TextEditingController(text: User.email);
    passwordController = TextEditingController(text: "password");
    super.initState();
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (image != null) {
        _image = image;
        check = 1;
      }
    });
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (image != null) {
        _image = image;
        check = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _controller = CircleColorPickerController(
      initialColor: Colors.blue,
    );
    return Scaffold(
      backgroundColor: darkBlack,
      body: SafeArea(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Setting',
                          style: GoogleFonts.oswald(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await logout().then((value) => Navigator.of(context)
                                .pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                              return login();
                            })));
                      },
                      child: Container(
                        width: 50,
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      check == 1
                          ? CircleAvatar(
                              backgroundImage: Image.file(
                                File(_image!.path),
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              ).image,
                              radius: 60,
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(
                                CupertinoIcons.person_solid,
                                size: 100,
                                color: darkBlack,
                              ),
                              radius: 60,
                            ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: CircleAvatar(
                          backgroundColor: orange,
                          radius: 12,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Accounts',
                            style:
                                GoogleFonts.oswald(fontSize: 24, color: orange),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                          child: Text(
                            "Username",
                            style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: userNameController,
                                style: GoogleFonts.quattrocento(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                cursorColor: Color(0xffffffff),
                                decoration: InputDecoration(
                                  fillColor: Color(0xff2D3337),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                enabled: isUsernameEditable,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isUsernameEditable = !isUsernameEditable;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isUsernameEditable
                                        ? orange
                                        : Colors.transparent),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                          child: Text(
                            "First Name",
                            style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: fnameController,
                                style: GoogleFonts.quattrocento(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                cursorColor: Color(0xffffffff),
                                decoration: InputDecoration(
                                  fillColor: Color(0xff2D3337),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                enabled: isFnameEditable,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFnameEditable = !isFnameEditable;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isFnameEditable
                                        ? orange
                                        : Colors.transparent),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                          child: Text(
                            "Last Name",
                            style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: lnameController,
                                style: GoogleFonts.quattrocento(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                cursorColor: Color(0xffffffff),
                                decoration: InputDecoration(
                                  fillColor: Color(0xff2D3337),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                enabled: isLnameEditable,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLnameEditable = !isLnameEditable;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isLnameEditable
                                        ? orange
                                        : Colors.transparent),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                          child: Text(
                            "Email",
                            style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: emailController,
                                style: GoogleFonts.quattrocento(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                cursorColor: Color(0xffffffff),
                                decoration: InputDecoration(
                                  fillColor: Color(0xff2D3337),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                enabled: isEmailEditable,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isEmailEditable = !isEmailEditable;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isEmailEditable
                                        ? orange
                                        : Colors.transparent),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                          child: Text(
                            "Password",
                            style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: passwordController,
                                obscureText: !isPasswordEditable,
                                style: GoogleFonts.quattrocento(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                                cursorColor: Color(0xffffffff),
                                decoration: InputDecoration(
                                  fillColor: Color(0xff2D3337),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                ),
                                enabled: isPasswordEditable,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPasswordEditable = !isPasswordEditable;
                                });
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isPasswordEditable
                                        ? orange
                                        : Colors.transparent),
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Drawer',
                            style:
                                GoogleFonts.oswald(fontSize: 24, color: orange),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ColorPicker(type: 1);
                                    }).then((value) {
                                  setState(() {});
                                });
                              },
                              child: Container(
                                width: 150,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xff2D3337),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "Pen Color",
                                  style: GoogleFonts.oswald(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ColorPicker(type: 2);
                                    }).then((value) {
                                  setState(() {});
                                });
                              },
                              child: Container(
                                width: 150,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xff2D3337),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  "Background Color",
                                  style: GoogleFonts.oswald(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 100,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: DrawingBoard.bgColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Am I Visible?',
                            style: TextStyle(
                                color: DrawingBoard.PenColor, fontSize: 30),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
