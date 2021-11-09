import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:learning_digital_ink_recognition/learning_digital_ink_recognition.dart';
import 'package:learning_digital_ink_recognition_example/painter.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DigitalInkRecognitionPage2 extends StatefulWidget {
  @override
  _DigitalInkRecognitionPage2State createState() =>
      _DigitalInkRecognitionPage2State();
}

class _DigitalInkRecognitionPage2State
    extends State<DigitalInkRecognitionPage2> {
  final String _model = 'en-US';

  DigitalInkRecognition2State get state => Provider.of(context, listen: false);
  late DigitalInkRecognition _recognition;

  double get _width => MediaQuery.of(context).size.width;
  double _height = 480;
  int hidePicker = 0;
  final _controller = CircleColorPickerController(
    initialColor: Colors.blue,
  );
  final _bgController = CircleColorPickerController(
    initialColor: Colors.blue,
  );
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    _recognition = DigitalInkRecognition(model: _model);
    super.initState();
  }

  @override
  void dispose() {
    _recognition.dispose();
    super.dispose();
  }

  void _speak(text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.0);

    await flutterTts.speak(text);
    // if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  // need to call start() at the first time before painting the ink
  Future<void> _init() async {
    //print('Writing Area: ($_width, $_height)');
    await _recognition.start(writingArea: Size(_width, _height));
    // always check the availability of model before being used for recognition
    await _checkModel();
  }

  // reset the ink recognition
  Future<void> _reset() async {
    state.reset();
    await _recognition.start(writingArea: Size(_width, _height));
  }

  Future<void> _checkModel() async {
    bool isDownloaded = await DigitalInkModelManager.isDownloaded(_model);

    if (!isDownloaded) {
      await DigitalInkModelManager.download(_model);
    }
  }

  Future<void> _actionDown(Offset point) async {
    state.startWriting(point);
    await _recognition.actionDown(point);
  }

  Future<void> _actionMove(Offset point) async {
    state.writePoint(point);
    await _recognition.actionMove(point);
  }

  Future<void> _actionUp() async {
    state.stopWriting();
    await _recognition.actionUp();
  }

  Future<void> _startRecognition() async {
    if (state.isNotProcessing) {
      state.startProcessing();
      // always check the availability of model before being used for recognition
      await _checkModel();
      state.data = await _recognition.process();
      print("data" + state.data.toString());
      state.stopProcessing();
      _speak(state.data[0].text);
    }
  }

  Future<void> _changePenColor(color) async {
    state.changePenColor(color);
  }

  Future<void> _changeBgColor(color) async {
    state.changeBgColor(color);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Builder(
              builder: (_) {
                _init();
                return GestureDetector(
                  onScaleStart: (details) async =>
                      await _actionDown(details.localFocalPoint),
                  onScaleUpdate: (details) async =>
                      await _actionMove(details.localFocalPoint),
                  onScaleEnd: (details) async => await _actionUp(),
                  child: Consumer<DigitalInkRecognition2State>(
                    builder: (_, state, __) => CustomPaint(
                      painter: DigitalInkPainter(
                          writings: state.writings,
                          strokeColor: state.penColor,
                          background: state.bgColor),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: _startRecognition,
                child: CircleAvatar(
                  child: Icon(Icons.play_arrow),
                  backgroundColor: Colors.amberAccent,
                ),
              ),
            ),
            Positioned(
              top: 70,
              right: 10,
              child: GestureDetector(
                onTap: _reset,
                child: CircleAvatar(
                  child: Icon(Icons.refresh),
                  backgroundColor: Colors.amberAccent,
                ),
              ),
            ),
            Positioned(
              top: 130,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (hidePicker == 1)
                      hidePicker = 0;
                    else
                      hidePicker = 1;
                  });
                },
                child: CircleAvatar(
                  child: Icon(Icons.border_color),
                  backgroundColor:
                      hidePicker != 1 ? Colors.amberAccent : Colors.red,
                ),
              ),
            ),
            Positioned(
              top: 190,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (hidePicker == 2)
                      hidePicker = 0;
                    else
                      hidePicker = 2;
                  });
                },
                child: CircleAvatar(
                  child: Icon(Icons.gradient),
                  backgroundColor:
                      hidePicker != 2 ? Colors.amberAccent : Colors.red,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: Consumer<DigitalInkRecognition2State>(
                  builder: (_, state, __) {
                if (state.isNotProcessing && state.isNotEmpty) {
                  return Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        state.toCompleteString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  );
                }
                if (state.isProcessing) {
                  return Center(
                    child: Container(
                      width: 36,
                      height: 36,
                      color: Colors.transparent,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }
                return Container();
              }),
            ),
            Visibility(
              visible: hidePicker == 1,
              child: Align(
                alignment: Alignment.center,
                child: CircleColorPicker(
                  controller: _controller,
                  onChanged: (color) {
                    setState(() {
                      _changePenColor(color);
                    });
                  },
                ),
              ),
            ),
            Visibility(
              visible: hidePicker == 2,
              child: Align(
                alignment: Alignment.center,
                child: CircleColorPicker(
                  controller: _bgController,
                  onChanged: (color) {
                    setState(() {
                      _changeBgColor(color);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DigitalInkRecognition2State extends ChangeNotifier {
  List<List<Offset>> _writings = [];
  List<RecognitionCandidate> _data = [];
  bool isProcessing = false;
  Color penColor = Colors.black;
  Color bgColor = Colors.yellow;

  List<List<Offset>> get writings => _writings;
  List<RecognitionCandidate> get data => _data;
  bool get isNotProcessing => !isProcessing;
  bool get isEmpty => _data.isEmpty;
  bool get isNotEmpty => _data.isNotEmpty;
  Color get getPenColor => penColor;
  Color get getBgColor => bgColor;
  List<Offset> _writing = [];

  void reset() {
    _writings = [];
    notifyListeners();
  }

  void startWriting(Offset point) {
    _writing = [point];
    _writings.add(_writing);
    notifyListeners();
  }

  void writePoint(Offset point) {
    if (_writings.isNotEmpty) {
      _writings[_writings.length - 1].add(point);
      notifyListeners();
    }
  }

  void stopWriting() {
    _writing = [];
    notifyListeners();
  }

  void startProcessing() {
    isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    isProcessing = false;
    notifyListeners();
  }

  void changePenColor(c) {
    penColor = c;
    notifyListeners();
  }

  void changeBgColor(c) {
    bgColor = c;
    notifyListeners();
  }

  set data(List<RecognitionCandidate> data) {
    _data = data;
    notifyListeners();
  }

  @override
  String toString() {
    return isNotEmpty ? _data.first.text : '';
  }

  String toCompleteString() {
    return isNotEmpty ? _data[0].text : '';
    // return isNotEmpty ? _data.map((c) => c.text).toList().join(', ') : '';
  }
}
