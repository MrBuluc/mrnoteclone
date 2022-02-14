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

  String passwordStr, showPassword = "";

  double ekranYuksekligi, ekranGenisligi;

  bool show = false;

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
          SizedBox(
            height: 10,
          ),
          currentPassword(),
          SizedBox(
            height: 10,
          ),
          changePassword(),
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

  Widget currentPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Text(
            "Şuanki Parola:",
            style: headerStyle7.copyWith(color: Colors.grey.shade900),
          ),
        ),
        Text(
          show ? passwordStr : showPassword,
          style: TextStyle(fontSize: 20),
        ),
        passwordStr != null
            ? GestureDetector(
                child: Icon(show ? Icons.visibility_off : Icons.visibility),
                onTap: () {
                  setState(() {
                    show = !show;
                  });
                },
              )
            : Container(
                width: 30,
              )
      ],
    );
  }

  Widget changePassword() {
    String bankSelected;
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40, bottom: 24, top: 12),
      child: Container(
        height: 55,
        width: ekranGenisligi,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: Colors.grey.shade400),
        child: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.grey.shade400,
              buttonTheme:
                  ButtonTheme.of(context).copyWith(alignedDropdown: true)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              iconEnabledColor: Colors.grey.shade400,
              items: [""]
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          height: 200,
                          width: ekranGenisligi - 125,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Parola Değiştir",
                                style: headerStyle3,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Form(
                                child: buildForm(),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              hint: Text(
                "Parolanı Değiştir",
                style: headerStyle7,
              ),
              onChanged: (String value) {
                setState(() {
                  bankSelected = value;
                });
              },
              value: bankSelected,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  hintText: "Parola",
                  border: OutlineInputBorder()),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              child: Text(
                "Kaydet",
                style: headerStyle7,
              ),
              style: ElevatedButton.styleFrom(primary: Colors.grey.shade800),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text(
                "İptal",
                style: headerStyle4,
              ),
              style: ElevatedButton.styleFrom(primary: settings.currentColor),
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }
}
