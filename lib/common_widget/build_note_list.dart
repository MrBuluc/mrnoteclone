import 'package:flutter/material.dart';
import 'package:mr_note_clone/common_widget/Platform_Duyarli_Alert_Dialog/platform_duyarli_alert_dialog.dart';
import 'package:mr_note_clone/const.dart';
import 'package:mr_note_clone/models/note.dart';
import 'package:mr_note_clone/models/settings.dart';
import 'package:mr_note_clone/services/database_helper.dart';
import 'package:mr_note_clone/ui/Note_Detail/note_detail.dart';

class BuildNoteList extends StatefulWidget {
  final bool isSorted;
  final int categoryID;

  BuildNoteList({this.isSorted, this.categoryID});

  @override
  _BuildNoteListState createState() => _BuildNoteListState();
}

class _BuildNoteListState extends State<BuildNoteList> {
  List<Note> allNotes = [];

  Settings settings = Settings();

  DatabaseHelper databaseHelper = DatabaseHelper();

  bool isSorted;

  int categoryID;

  @override
  void initState() {
    super.initState();
    isSorted = widget.isSorted;
    categoryID = widget.categoryID;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: fillAllNotes(),
      builder: (context, _) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: allNotes.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Dismissible(
                  key: Key(allNotes[index].id.toString()),
                  onDismissed: (direction) {
                    int noteID = allNotes[index].id;
                    setState(() {
                      allNotes.removeAt(index);
                    });
                    _areYouSureforDelete(noteID);
                  },
                  background: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, left: 100),
                      child: Text(
                        "Kaldır",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  child: GestureDetector(
                    child: Container(
                      height: 130,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: settings.switchBackgroundColor(),
                          borderRadius: borderRadius1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 110,
                            width: size.width * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      allNotes[index].title.length > 10
                                          ? allNotes[index]
                                                  .title
                                                  .substring(0, 10) +
                                              "..."
                                          : allNotes[index].title,
                                      style: headerStyle5,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      databaseHelper.dateFormat(
                                          DateTime.parse(allNotes[index].time)),
                                      style: headerStyle3_2,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  allNotes[index].content.length > 50
                                      ? allNotes[index]
                                              .content
                                              .replaceAll("\n", " ")
                                              .substring(0, 50) +
                                          "..."
                                      : allNotes[index].content,
                                  style: headerStyle4,
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _setPriorityIcon(allNotes[index].priority),
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        Color(allNotes[index].categoryColor)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NoteDetail(
                                    updateNote: allNotes[index],
                                  )));
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            );
          },
        );
      },
    );
  }

  Future fillAllNotes() async {
    //List<Note> allNotes1;
    if (isSorted != null) {
      String suan = DateTime.now().toString().substring(0, 10);
      allNotes = await databaseHelper.getSortNoteList(suan);
    } else if (categoryID != null) {
      if (categoryID == 0)
        allNotes = await databaseHelper.getNoteList();
      else
        allNotes = await databaseHelper.getCategoryNotesList(categoryID);
    }
  }

  _setPriorityIcon(int priority) {
    switch (priority) {
      case 0:
        return CircleAvatar(
          child: Text(
            "Düşük",
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
          backgroundColor: Colors.green,
        );
        break;
      case 1:
        return CircleAvatar(
          child: Text(
            "Orta",
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
          backgroundColor: Colors.yellow,
        );
        break;
      case 2:
        return CircleAvatar(
          child: Text(
            "Yüksek",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          backgroundColor: Color(0xFFff0000),
        );
        break;
    }
  }

  Future _areYouSureforDelete(int noteID) async {
    bool sonuc = await PlatformDuyarliAlertDialog(
            baslik: "Emin misiniz?",
            icerik: "1 not silinecek",
            anaButonYazisi: "SİL",
            iptalButonYazisi: "İPTAL")
        .goster(context);

    if (sonuc) _delNote(noteID);
  }

  Future _delNote(int noteID) async {
    int sonuc = await databaseHelper.deleteNote(noteID);
    if (sonuc != 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("1 Not Silindi")));
      setState(() {});
    }
  }
}
