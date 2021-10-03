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
}
