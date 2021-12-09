import 'package:flutter/material.dart';
import 'package:mr_note_clone/common_widget/Platform_Duyarli_Alert_Dialog/platform_duyarli_alert_dialog.dart';
import 'package:mr_note_clone/common_widget/merkez_widget.dart';
import 'package:mr_note_clone/const.dart';
import 'package:mr_note_clone/models/category.dart';
import 'package:mr_note_clone/models/note.dart';
import 'package:mr_note_clone/models/settings.dart';
import 'package:mr_note_clone/services/database_helper.dart';

class NoteDetail extends StatefulWidget {
  final Note updateNote;

  NoteDetail({this.updateNote});

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  List<Category> allCategories = [];

  DatabaseHelper databaseHelper = DatabaseHelper();

  Note updateNote;

  int categoryID, selectedPriority, counter = 0;

  Color backgroundColor;

  Settings settings = Settings();

  bool isChanged = false, readed = false;

  GlobalKey formKey = GlobalKey<FormState>();

  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (isChanged) {
          final sonuc = await PlatformDuyarliAlertDialog(
            baslik: "Emin misiniz?",
            icerik: "Değişikliklerinizi kaydetmek mi yoksa iptal etmek mi "
                "istiyorsunuz?",
            anaButonYazisi: "KAYDET",
            iptalButonYazisi: "İPTAL",
          ).goster(context);

          if (sonuc) {
            //save(context);
            return false;
          }
        }
        return true;
      },
      child: SafeArea(
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: 5,
                  child: Icon(
                    Icons.save,
                    color: Colors.grey.shade700,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            backgroundColor: backgroundColor,
            body: FutureBuilder(
              future: readCategories(),
              builder: (context, _) {
                if (!readed) {
                  return MerkezWidget(children: [CircularProgressIndicator()]);
                } else {
                  if (allCategories.isEmpty) {
                    return Center(
                      child: Text(
                        "Lütfen önce bir kategori oluşturun!",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Container(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [buildAppBar()],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future readCategories() async {
    if (counter == 0) {
      allCategories = await databaseHelper.getCategoryList();
      if (allCategories.isNotEmpty) {
        if (widget.updateNote != null) {
          updateNote = widget.updateNote;
          categoryID = updateNote.categoryID;
          selectedPriority = updateNote.priority;
          backgroundColor = Color(updateNote.categoryColor);
        } else {
          backgroundColor = settings.currentColor;
          categoryID = allCategories[0].id;
          selectedPriority = 0;
        }
      }
      readed = true;
      counter++;
    }
  }

  Widget buildAppBar() {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                Icons.close,
                size: 40,
                color: Colors.grey.shade400,
              ),
            ),
            SizedBox(
              width: size.width * 0.25,
            ),
            dropDown(),
            SizedBox(
              width: size.width * 0.05,
            ),
            dropDownPriorty()
          ],
        ),
      ),
    );
  }

  Widget dropDown() {
    return DropdownButton(
      value: categoryID,
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 20,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.transparent,
      ),
      onChanged: (selectedCategoryID) {
        isChanged = true;
        setState(() {
          categoryID = selectedCategoryID;
        });
      },
      items: createCategoryItem(),
    );
  }

  List<DropdownMenuItem<int>> createCategoryItem() {
    return allCategories
        .map((category) => DropdownMenuItem<int>(
              value: category.id,
              child: Text(
                category.categoryTitle,
                style: headerStyle3,
              ),
            ))
        .toList();
  }

  Widget dropDownPriorty() {
    List<String> priority = ["Düşük", "Orta", "Yüksek"];
    return DropdownButton<int>(
      value: selectedPriority,
      icon: Icon(Icons.keyboard_arrow_down),
      iconSize: 20,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        color: Colors.transparent,
      ),
      onChanged: (selectedPriorityID) {
        isChanged = true;
        setState(() {
          selectedPriority = selectedPriorityID;
        });
      },
      items: priority
          .map((e) => DropdownMenuItem<int>(
                child: Text(
                  e,
                  style: headerStyle3_1,
                ),
                value: priority.indexOf(e),
              ))
          .toList(),
    );
  }
}
