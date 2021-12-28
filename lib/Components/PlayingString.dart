import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../tts.dart';

class PlayingString extends StatefulWidget {
  final String text;
  const PlayingString({Key? key, required this.text}) : super(key: key);

  @override
  _PlayingStringState createState() => _PlayingStringState();
}

class _PlayingStringState extends State<PlayingString> {
  late String text;
  int isPlaying = 0;
  @override
  void initState() {
    text = widget.text;
    super.initState();
  }

  void updateStatus() {
    setState(() {
      print("outside");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          color: Color(0xff282828), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
          Container(
            child: Row(
              children: [
                Visibility(
                  visible: tts.ttsState == TtsState.stopped,
                  // tts.currentState() == TtsState.stopped,

                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPlaying = 1;
                        print("inside");
                        tts.speakString(text, updateStatus);
                      });
                    },
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                Visibility(
                  visible: tts.ttsState == TtsState.playing,
                  //tts.currentState() != TtsState.stopped,
                  child: Container(
                    width: 30,
                    height: 30,
                    child: LoadingIndicator(
                        indicatorType: Indicator.lineScaleParty,
                        colors: const [Colors.white],
                        strokeWidth: 2,
                        backgroundColor: Colors.black,
                        pathBackgroundColor: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
