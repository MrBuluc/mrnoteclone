import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mr_note_clone/models/settings.dart';

import '../../const.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Color currentColor;

  Settings settings = Settings();

  String passwordStr, showPassword;

  double ekranYuksekligi, ekranGenisligi;

  @override
  void initState() {
    super.initState();
    currentColor = settings.currentColor;
    passwordStr = settings.password;
    prepareShowPassword();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ekranYuksekligi = size.height;
    ekranGenisligi = size.width;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: currentColor,
      body: Column(
        children: [
          buildHeader(size),
          SizedBox(
            height: 10,
          ),
          changeColorWidget(),
        ],
      ),
    ));
  }

  prepareShowPassword() {
    if (passwordStr != null)
      setState(() {
        //passwordStr = "1234"
        //showPassword = "****"
        showPassword = "*" * (passwordStr.length);
      });
  }

  Widget buildHeader(Size size) {
    return Container(
      height: 180,
      width: ekranGenisligi,
      color: Colors.grey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Ayarlar",
              style: headerStyle6,
            ),
          )
        ],
      ),
    );
  }

  Widget changeColorWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Tema Rengi:",
            style: headerStyle7.copyWith(color: Colors.grey.shade900),
          ),
        ),
        ElevatedButton(
          child: Text(
            "Renk Seç",
            style: TextStyle(color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
              primary: Colors.grey.shade400, elevation: 3),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Bir Renk Seçin"),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        pickerColor: settings.currentColor,
                        onColorChanged: (Color color) {
                          setState(() {
                            currentColor = color;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                });
          },
        )
      ],
    );
  }
}
