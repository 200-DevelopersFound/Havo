import 'package:flutter_tts/flutter_tts.dart';

class tts {
  static late FlutterTts flutterTts;
  static ttsInit() {
    flutterTts = FlutterTts();
  }

  static void setLanguage(String s) async {
    await flutterTts.setLanguage(s);
  }

  static void setSpeechRate(double i) async {
    await flutterTts.setSpeechRate(i);
  }

  static void setVolume(double i) async {
    await flutterTts.setVolume(i);
  }

  static void setPitch(double i) async {
    await flutterTts.setPitch(1.0);
  }

  static void speak(text) async {
    await flutterTts.speak(text);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }
}
