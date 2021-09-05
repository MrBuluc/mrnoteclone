class SettingsDb {
  String password;
  String theme;
  String sort;

  SettingsDb(this.password, this.theme, this.sort);

  SettingsDb.fromListMap(List<Map<String, dynamic>> settingsMapList) {
    this.password = settingsMapList[0]["value"];
    this.theme = settingsMapList[1]["value"];
    this.sort = settingsMapList[2]["value"];
  }
}
