import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition_example/Api/CategoryApi.dart';

import 'CustomTextField.dart';

class CustomDialog extends StatefulWidget {
  final int onTap;
  const CustomDialog({required this.onTap, Key? key}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController mController = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: 220,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff282828),
          border: Border.all(color: Colors.white.withOpacity(0.2), width: 3),
        ),
        child: Column(
          children: [
            Text(
              'Add Category',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
                margin: const EdgeInsets.only(left: 5, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Name',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
            CustomTextField(
              controller: mController,
              height: 14,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (widget.onTap == 1)
                      await CategoryApi.addCategory(mController.text)
                          .then((value) async {
                        if (value == true) {
                          print('true');
                          await CategoryApi.getCategory();
                          Navigator.of(context).pop();
                        } else
                          print('false');
                      });
                    if (widget.onTap == 2)
                      await CategoryApi.updateCategory(mController.text)
                          .then((value) {
                        if (value == true) {
                          print('true');
                          Navigator.of(context).pop();
                        } else
                          print('false');
                      });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
