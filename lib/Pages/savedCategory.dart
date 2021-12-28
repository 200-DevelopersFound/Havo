import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition_example/Api/CategoryApi.dart';
import 'package:learning_digital_ink_recognition_example/Components/CustomDialog.dart';
import 'package:learning_digital_ink_recognition_example/Pages/CategoryStringPage.dart';
import 'package:learning_digital_ink_recognition_example/Pages/main.dart';
import 'package:learning_digital_ink_recognition_example/model/category.dart';

import '../constants/colors.dart';

class SavedCategoryPage extends StatefulWidget {
  const SavedCategoryPage({Key? key}) : super(key: key);

  @override
  _SavedCategoryPageState createState() => _SavedCategoryPageState();
}

class _SavedCategoryPageState extends State<SavedCategoryPage> {
  List<Category> categoryList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryList = CategoryApi.getDummy();
    CategoryApi.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = new TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [darkBlack, lightBlack])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    onTap: () async {
                      // await addCategory();
                    },
                  );
                });
          },
          backgroundColor: orange,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 40,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text('Saved Category',
                          style: TextStyle(color: Colors.white, fontSize: 23)),
                    ),
                  ),
                  Container(
                    width: 40,
                    child: CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(
                          'https://randomuser.me/api/portraits/women/' +
                              Random().nextInt(100).toString() +
                              '.jpg'),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                height: 45,
                child: TextField(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                  cursorColor: Color(0xffffffff),
                  controller: searchController,
                  decoration: InputDecoration(
                    fillColor: Color(0xff404040),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    suffixIcon: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Category>>(
                    future: CategoryApi.getCategory(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Container(
                              child: Text(
                                'Some Error occured',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }

                        return CategoryListCard(categoryList: categoryList);
                      } else
                        return Center(
                          child: Container(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator()),
                        );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryListCard extends StatelessWidget {
  const CategoryListCard({
    Key? key,
    required this.categoryList,
  }) : super(key: key);

  final List<Category> categoryList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < 10; i++)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryStringPage(i),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                margin: EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                    color: Color(0xff282828),
                    // border: Border.all(
                    //     color: Colors.white.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(categoryList[i].title,
                        style: TextStyle(color: Colors.white, fontSize: 23)),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
