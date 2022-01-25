class Note {
  int id;
  int categoryID;
  String categoryTitle;
  int categoryColor;
  String title;
  String content;
  String time;
  int priority;

  Note(this.categoryID, this.title, this.content, this.time, this.priority);

  Note.withID(this.id, this.categoryID, this.title, this.content, this.time,
      this.priority);

  Note.all(this.id, this.categoryID, this.categoryTitle, this.categoryColor,
      this.title, this.content, this.priority, this.time);

  Note.fromMap(Map map) {
    this.id = map["id"];
    this.categoryID = map["categoryID"];
    this.categoryTitle = map["categoryTitle"];
    this.categoryColor = int.parse(map["categoryColor"]);
    this.title = map["noteTitle"];
    this.content = map["content"];
    this.time = map["time"];
    this.priority = map["priority"];
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "categoryID": categoryID,
        "noteTitle": title,
        "content": content,
        "time": time,
        "priority": priority
      };
}
