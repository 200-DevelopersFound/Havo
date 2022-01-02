import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:havo/constants/colors.dart';
import 'package:havo/model/drawer.dart';
import 'package:progress_loading_button/progress_loading_button.dart';

class ColorPicker extends StatefulWidget {
  final int type;
  const ColorPicker({required this.type, Key? key}) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  final _controller = CircleColorPickerController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff282828),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleColorPicker(
              textStyle: TextStyle(fontSize: 20, color: Colors.white),
              controller: _controller,
              onChanged: (color) {
                setState(() {
                  if (widget.type == 1) DrawingBoard.PenColor = color;
                  if (widget.type == 2) DrawingBoard.bgColor = color;
                });
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: LoadingButton(
                  color: orange,
                  defaultWidget: Text(
                    'Save',
                    style: GoogleFonts.oswald(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            )
          ],
        ),
      ),
    );
  }
}
