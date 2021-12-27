import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition_example/Api/CategoryApi.dart';
import 'package:learning_digital_ink_recognition_example/Pages/savedCategory.dart';
import 'package:learning_digital_ink_recognition_example/tts.dart';

import 'login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CategoryApi.CategoryApiInit();
  tts.ttsInit();
  runApp(MyApp());
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
          // SavedCategoryPage(),
          login(),

      // ChangeNotifierProvider(
      //   create: (_) => DigitalInkRecognition2State(),
      //   child: DigitalInkRecognitionPage2(),
      // ),
    );
  }
}
