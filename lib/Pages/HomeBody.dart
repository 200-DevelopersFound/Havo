import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_digital_ink_recognition_example/Api/CategoryApi.dart';
import 'package:learning_digital_ink_recognition_example/Components/BlurredCard.dart';
import 'package:learning_digital_ink_recognition_example/Components/Ink.dart';
import 'package:learning_digital_ink_recognition_example/Pages/savedCategory.dart';
import 'package:learning_digital_ink_recognition_example/constants/colors.dart';
import 'package:progress_loading_button/progress_loading_button.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  TextEditingController mController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi User!',
                      style: GoogleFonts.oswald(
                          fontSize: 34,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/women/' +
                              Random().nextInt(100).toString() +
                              '.jpg'),
                    )
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          BlurredCard(
                              heading: 'Drawing board',
                              subheading:
                                  "Let's you write in the drawing board and convert your text into voice",
                              icon: Icons.gesture,
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ChangeNotifierProvider(
                                    create: (_) =>
                                        DigitalInkRecognition2State(),
                                    child: DigitalInkRecognitionPage2(),
                                  );
                                })).then((value) {
                                  setState(() {});
                                });
                              }),
                          SizedBox(
                            width: 10,
                          ),
                          BlurredCard(
                              heading: 'Saved',
                              subheading:
                                  "See your saved message and lets you easily convert into voice",
                              icon: Icons.list_alt_outlined,
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SavedCategoryPage();
                                })).then((value) {
                                  setState(() {});
                                });
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              children: [
                                Text(
                                  'Total Category',
                                  style: GoogleFonts.oswald(
                                      fontSize: 18,
                                      color: orange,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '120+',
                                  style: GoogleFonts.oswald(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 3,
                            decoration: BoxDecoration(
                              color: orange,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Total Dialogues',
                                      style: GoogleFonts.oswald(
                                          fontSize: 18,
                                          color: orange,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '120+',
                                      style: GoogleFonts.oswald(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 10),
                            child: Text(
                              'Add Category',
                              style: GoogleFonts.oswald(
                                  color: Colors.white, fontSize: 22),
                            ),
                          ),
                          TextField(
                            controller: mController,
                            cursorColor: Colors.white,
                            style: GoogleFonts.oswald(color: Colors.white),
                            decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                fillColor: lightBlack.withOpacity(0.6)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: LoadingButton(
                                height: 40,
                                borderRadius: 15,
                                onPressed: () async {
                                  await CategoryApi.addCategory(
                                          mController.text)
                                      .then((value) async {
                                    if (value == true) {
                                      print('true');
                                      await CategoryApi.getCategory();
                                      // Navigator.of(context).pop();
                                    } else
                                      print('false');
                                  });
                                },
                                loadingWidget: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                color: orange,
                                defaultWidget: Text(
                                  'Add',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.oswald(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
