import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:havo/Api/CategoryApi.dart';
import 'package:havo/Components/CustomDialog.dart';
import 'package:havo/Components/PlayingString.dart';
import 'package:havo/constants/colors.dart';
import 'package:havo/model/category.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CategoryStringPage extends StatefulWidget {
  final int idx;
  CategoryStringPage(
    this.idx,
  );
  @override
  _CategoryStringPageState createState() => _CategoryStringPageState();
}

class _CategoryStringPageState extends State<CategoryStringPage> {
  late int idx;
  @override
  void initState() {
    super.initState();
    idx = widget.idx;
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
                  onTap: 2,
                  id: CategoryApi.categoryList[idx].id,
                );
              },
            ).then((value) => setState(() {}));
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
                      child: Text(
                        CategoryApi.categoryList[idx].title,
                        style: GoogleFonts.firaSans(
                            color: Colors.white, fontSize: 23),
                        overflow: TextOverflow.ellipsis,
                      ),
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
                child: DialoguesListCard(
                    categoryList: CategoryApi.categoryList, idx: idx),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DialoguesListCard extends StatelessWidget {
  const DialoguesListCard({
    Key? key,
    required this.categoryList,
    required this.idx,
  }) : super(key: key);

  final List<Category> categoryList;
  final int idx;

  @override
  Widget build(BuildContext context) {
    Category x = categoryList[idx];
    if (categoryList[idx].dialogues.length == 0)
      return Center(
          child: Container(
        child: Text(
          'Hey looking for something? Actually you forgot to add First',
          style: TextStyle(color: Colors.white),
        ),
      ));
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < categoryList[idx].dialogues.length; i++)
            PlayingString(text: categoryList[idx].dialogues[i]),
        ],
      ),
    );
  }
}
