class SettingsDb {
  String password;
  String theme;
  String sort;

  SettingsDb(this.password, this.theme, this.sort);

  SettingsDb.fromMap(Map<String, dynamic> settingsMap) {
    this.password = settingsMap["password"];
    this.theme = settingsMap["theme"];
    this.sort = settingsMap["sort"];
  }

  @override
  String toString() {
    return 'SettingsDb{password: $password, theme: $theme, sort: $sort}';
  }
}
