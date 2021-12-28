import 'dart:convert';

import 'package:learning_digital_ink_recognition_example/Api/CategoryApi.dart';

class Category {
  String id, title;
  List<String> dialogues;
  Category({required this.id, required this.title, required this.dialogues});
  factory Category.fromJson(Map<String, dynamic> json) {
    print('gotcha2');
    print(json);
    var ls = List<String>.from(json['dialogues'].where((i) => i.flag == true));
    print('disajidsa');
    print(ls);
    return new Category(
        id: json['_id'],
        title: json['title'],
        dialogues:
            List<String>.from(json['dialogues'].where((i) => i.flag == true)));
  }
  static List<Category> allCategoryFromJson(String str) {
    final jsonData = json.decode(str);
    print('gotcha');
    return new List<Category>.from(jsonData.map((x) => Category.fromJson(x)));
  }

  static List<String> getDialogues(int idx) {
    return CategoryApi.categoryList[idx].dialogues;
  }
}
