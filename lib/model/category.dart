import 'dart:convert';

class Category {
  String id, title;
  List<String> dialogues;
  Category({required this.id, required this.title, required this.dialogues});
  factory Category.fromJson(Map<String, dynamic> json) {
    print('gotcha2');
    print(json);
    return new Category(id: json[''], title: json[''], dialogues: json['']);
  }
  static List<Category> allCategoryFromJson(String str) {
    final jsonData = json.decode(str);
    print('gotcha');
    return new List<Category>.from(jsonData.map((x) => Category.fromJson(x)));
  }
}
