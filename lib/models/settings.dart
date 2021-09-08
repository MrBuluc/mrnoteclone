import 'package:flutter/material.dart';

class Settings {
  static Settings _settings;
  String password;
  Color currentColor;
  String sort;

  factory Settings() {
    if (_settings == null) {
      _settings = Settings.internal();
      return _settings;
    } else {
      return _settings;
    }
  }

  Settings.internal();
}
