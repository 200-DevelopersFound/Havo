import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_digital_ink_recognition_example/Api/CategoryApi.dart';
import 'package:learning_digital_ink_recognition_example/Pages/savedCategory.dart';
import 'package:learning_digital_ink_recognition_example/Pages/setting.dart';
import 'package:learning_digital_ink_recognition_example/tts.dart';

import 'Home.dart';
import 'login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  CategoryApi.CategoryApiInit();
  tts.ttsInit();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
      ),
      home:
          //  SavedCategoryPage(),
          login(),
    );
  }
}
