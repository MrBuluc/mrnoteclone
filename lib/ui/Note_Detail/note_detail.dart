import 'package:flutter/material.dart';
import 'package:mr_note_clone/common_widget/Platform_Duyarli_Alert_Dialog/platform_duyarli_alert_dialog.dart';
import 'package:mr_note_clone/common_widget/merkez_widget.dart';
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

  int categoryID, selectedPriority;

  Color backgroundColor;

  Settings settings = Settings();

  bool isChanged = false, readed = false;

  @override
  Widget build(BuildContext context) {
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
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future readCategories() async {
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
  }
}
