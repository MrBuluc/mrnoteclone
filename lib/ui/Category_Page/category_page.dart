import 'package:flutter/material.dart';
import 'package:mr_note_clone/models/category.dart';

import '../../const.dart';

class CategoryPage extends StatefulWidget {
  final Category category;

  CategoryPage({@required this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Category category;

  int lenght = 0;

  @override
  void initState() {
    super.initState();
    category = widget.category;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: scaffoldColor,
      body: Column(
        children: [
          buildHeader(size),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Buralar soğuk gözüküyor 🥶\n" + "Hadi biraz ısıtalım 🥳",
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Widget buildHeader(Size size) {
    return Container(
      height: 220,
      color: Color(category.color),
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Text(
              category.categoryTitle,
              style: headerStyle6,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                "$lenght Notlar",
                style: headerStyle7,
              ),
            )
          ],
        ),
      ),
    );
  }
}
