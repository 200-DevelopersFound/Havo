import 'dart:math';
import 'package:flutter/material.dart';
import 'package:learning_digital_ink_recognition_example/Api/CategoryApi.dart';
import 'package:learning_digital_ink_recognition_example/constants/colors.dart';
import 'package:learning_digital_ink_recognition_example/model/category.dart';

import 'main.dart';

class CategoryStringPage extends StatefulWidget {
  final int idx;
  CategoryStringPage(
    this.idx,
  );
  @override
  _CategoryStringPageState createState() => _CategoryStringPageState();
}

class _CategoryStringPageState extends State<CategoryStringPage> {
  List<Category> categoryList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryList = categoryApi.getDummy();
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
          onPressed: () {},
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
                      child: Text('Introduction',
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
                    fillColor: Color(0xff2D3337),
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < 2; i++)
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          margin: EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.02),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(categoryList[widget.idx].strings[i],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 23)),
                              Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
