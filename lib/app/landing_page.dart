import 'package:flutter/material.dart';
import 'package:mr_note_clone/common_widget/merkez_widget.dart';
import 'package:mr_note_clone/models/settings.dart';
import 'package:mr_note_clone/models/settingsdb.dart';
import 'package:mr_note_clone/services/database_helper.dart';
import 'package:mr_note_clone/ui/Login/login.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  bool flag = false;

  Settings settings = Settings();

  @override
  void initState() {
    super.initState();
    read().then((value) => flag = value);
  }

  @override
  Widget build(BuildContext context) {
    if (settings.currentColor != null && settings.sort != null) {
      // if (flag) {
      //   return Login();
      // } else {
      //   return HomePage();
      // }
      return Login();
    } else {
      return Scaffold(
        backgroundColor: Color(0xff84b7f1),
        body: MerkezWidget(
          children: [
            Image.asset(
              "assets/icon.png",
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff1c984)),
            )
          ],
        ),
      );
    }
  }

  Future<bool> read() async {
    SettingsDb settingsDb = await databaseHelper.getSettings();
    settings.password = settingsDb.password;

    try {
      int color = int.parse(settingsDb.theme);
      settings.currentColor = Color(color);
    } catch (_) {
      settings.currentColor = Color(4293914607);
    }

    try {
      settings.sort = settingsDb.sort;
    } catch (_) {
      settings.sort = "3/1";
    }
    setState(() {});

    return settings.password != null && settings.password.isNotEmpty;
  }
}
