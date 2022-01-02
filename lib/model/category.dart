import 'dart:convert';

import 'package:havo/Api/CategoryApi.dart';

class Category {
  String id, title;
  List<String> dialogues;
  Category({required this.id, required this.title, required this.dialogues});
  factory Category.fromJson(Map<String, dynamic> json) {
    List<String> mList = [];
    int size = json['dialogues'].length;
    for (int i = 0; i < size; i++) mList.add(json['dialogues'][i].toString());
    // print(json['title']);
    // print(mList.runtimeType);
    // print(mList);
    return new Category(
        id: json['_id'], title: json['title'], dialogues: mList);
  }
  static List<Category> allCategoryFromJson(String str) {
    // print("herecheck");
    final jsonData = json.decode(str);
    List<Category> mList = [];
    for (int i = 0; i < jsonData.length; i++)
      mList.add(Category.fromJson(jsonData[i]));
    return mList;
    // jsonData[0].map((x) {
    //   print("check:" + x);
    //   // Category.fromJson(x);
    // });
    // return new List<Category>.from(jsonData.map((x) {
    //   print("check:" + x);
    //   Category.fromJson(x);
    // }));
  }

  static List<String> getDialogues(int idx) {
    return CategoryApi.categoryList[idx].dialogues;
  }
}
