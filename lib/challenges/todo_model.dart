class TodoModel {
  TodoModel({
    // required this.id,
    this.id,
    required this.title,
    required this.detail,
  });

  int? id;
  String title;
  String detail;
}
