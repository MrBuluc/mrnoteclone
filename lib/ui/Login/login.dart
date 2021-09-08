import 'package:flutter/material.dart';
import 'package:mr_note_clone/const.dart';
import 'package:mr_note_clone/models/settings.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Settings settings = Settings();

  String result = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: settings.currentColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildHeader(),
              buildTextForm(),
              buildResult(),
            ],
          ),
        ),
      ),
    );
  }

  buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        "Parolanızı Giriniz",
        style: headerStyle3,
      ),
    );
  }

  buildTextForm() {
    return Container(
      height: 200,
      width: 350,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3))
          ]),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextFormField(
                obscureText: true,
                style: headerStyle4,
                decoration: InputDecoration(
                    hintText: "Parola",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: generalColor,
                    )),
              ),
            ),
            buildSave()
          ],
        ),
      ),
    );
  }

  buildSave() {
    return Padding(
      padding: const EdgeInsets.only(right: 50, top: 30, left: 50),
      child: Container(
        height: 40,
        width: 80,
        decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: GestureDetector(
            child: Text(
              "Giriş",
              style: headerStyle11,
            ),
          ),
        ),
      ),
    );
  }

  buildResult() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        result,
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
