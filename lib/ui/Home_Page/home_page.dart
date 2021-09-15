import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_note_clone/const.dart';
import 'package:mr_note_clone/models/category.dart';
import 'package:mr_note_clone/models/settings.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Settings settings = Settings();

  List<Category> allCategories = [Category("Tüm Notlar", 4289760505)];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: settings.currentColor,
      body: ListView(
        children: [
          SizedBox(
            height: 25,
          ),
          header(),
          categoriesAndNew(),
          buildCategories(size),
          // Notes()
        ],
      ),
    ));
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Ana Sayfa",
            style: headerStyle,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: settings.currentColor),
            child: Text(
              "Ara",
              style: headerStyle3,
            ),
            onPressed: () {},
          ),
          GestureDetector(
            child: Icon(
              Icons.settings,
              color: Colors.grey.shade800,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  Widget categoriesAndNew() {
    return Container(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 30, top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Kategoriler",
              style: headerStyle2,
            ),
            GestureDetector(
              child: Text(
                "+Yeni",
                style: headerStyle3,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCategories(Size size) {
    return Container(
      height: 130,
      width: size.width,
      child: ListView.builder(
        itemCount: allCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: borderRadius1,
                    color: settings.switchBackgroundColor()),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(allCategories[index].color)),
                      ),
                      Text(
                        allCategories[index].categoryTitle,
                        style: switchCategoriesTitleStyle(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  TextStyle switchCategoriesTitleStyle() {
    switch (settings.currentColor.hashCode) {
      //Siyah renk
      case 4278190080:
        return headerStyle4.copyWith(color: Colors.white);
      default:
        return headerStyle4;
    }
  }
}

class Notes {}
