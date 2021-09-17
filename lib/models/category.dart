class Category {
  int id;
  String categoryTitle;
  int color;

  //Kategori eklerken
  Category(this.categoryTitle, this.color);

  Category.fromMap(Map<String, dynamic> map) {
    this.categoryTitle = map["categoryTitle"];
    this.id = map["categoryID"];
    this.color = int.parse(map["categoryColor"]);
  }

  //db den okurken
  Category.withID(this.id, this.categoryTitle, this.color);
}
