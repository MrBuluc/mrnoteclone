import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mr_note_clone/common_widget/Platform_Duyarli_Alert_Dialog/platform_duyarli_alert_dialog.dart';
import 'package:mr_note_clone/const.dart';
import 'package:mr_note_clone/models/category.dart';
import 'package:mr_note_clone/models/settings.dart';
import 'package:mr_note_clone/services/database_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Settings settings = Settings();

  List<Category> allCategories = [];

  DatabaseHelper databaseHelper = DatabaseHelper();

  String newCategoryTitle;

  Color currentColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (allCategories.isEmpty) updateCategoryList();
    return WillPopScope(
      onWillPop: () {
        return _areYouSureforExit();
      },
      child: SafeArea(
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
      )),
    );
  }

  void updateCategoryList() {
    databaseHelper.getCategoryList().then((categoryList) {
      categoryList.insert(
          0, Category.withID(0, "Tüm Notlar", settings.currentColor.value));
      setState(() {
        allCategories = categoryList;
      });
    });
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
            onPressed: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
          GestureDetector(
            child: Icon(
              Icons.settings,
              color: Colors.grey.shade800,
              size: 30,
            ),
            onTap: () async {
              // String result = await Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => SettingsPage());
              // );
              // if (result != null)
              //   updateCategoryList();
              // else
              //   setState(() {});
            },
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
              onTap: () {
                addCategoryDialog(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void addCategoryDialog(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              "Kategori Ekle",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Kategori Adı",
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value.length < 3)
                        return "Lütfen en az 3 karakter giriniz";
                      else
                        return null;
                    },
                    onSaved: (value) => newCategoryTitle = value,
                  ),
                ),
              ),
              changeColorWidget(context),
              ButtonBar(
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(primary: Colors.orangeAccent),
                    child: Text(
                      "İptal ❌",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                    child: Text(
                      "Kaydet 💾",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  )
                ],
              )
            ],
          );
        });
  }

  Widget changeColorWidget(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter blockPickerState) {
      return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Text(
              "Bir Renk Seç",
              style: TextStyle(
                  color: Theme.of(context).primaryColor, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80),
            child: GestureDetector(
              child: Container(
                height: 30,
                width: 30,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: currentColor),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Bir Renk Seç"),
                        content: BlockPicker(
                          pickerColor: currentColor,
                          onColorChanged: (Color color) {
                            Navigator.pop(context);
                            blockPickerState(() => currentColor = color);
                          },
                        ),
                      );
                    });
              },
            ),
          )
        ],
      );
    });
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

  Future<bool> _areYouSureforExit() async {
    final sonuc = await PlatformDuyarliAlertDialog(
      baslik: "Emin misiniz?",
      icerik: "Mr. Note Clone dan çıkmak istediğinize emin misiniz?",
      anaButonYazisi: "ÇIK",
      iptalButonYazisi: "İPTAL",
    ).goster(context);

    return Future.value(sonuc);
  }
}

class Notes {}
