import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, continued }

class tts {
  static late FlutterTts flutterTts;
  static late TtsState ttsState;
  static ttsInit() {
    flutterTts = FlutterTts();
    ttsState = TtsState.stopped;
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
    int result = await flutterTts.speak(text);
    if (result == 1) ttsState = TtsState.playing;
    flutterTts.setCompletionHandler(() {
      ttsState = TtsState.stopped;
    });
  }

  static void speakString(text, Function update) async {
    int result = await flutterTts.speak(text);
    if (result == 1) ttsState = TtsState.playing;
    flutterTts.setCompletionHandler(() {
      ttsState = TtsState.stopped;
      update.call();
    });
  }

  static TtsState currentState() {
    return ttsState;
  }
}
