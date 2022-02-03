import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_note_clone/models/note.dart';
import 'package:mr_note_clone/models/settings.dart';
import 'package:mr_note_clone/services/database_helper.dart';

import '../../const.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Settings settings = Settings();

  List<Note> allNotes = [];

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: settings.currentColor,
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(hintText: "Ara"),
          autofocus: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 150.0 * allNotes.length,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: allNotes.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 130,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white, borderRadius: borderRadius1),
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
                                                  .substring(0, 11) +
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
                                  allNotes[index].content.length >= 50
                                      ? allNotes[index]
                                              .content
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
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
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
}
