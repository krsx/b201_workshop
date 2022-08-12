class TodoModel {
  String? id;
  String title;
  String detail;
  bool isDone;

  TodoModel({
    // required this.id,
    this.id,
    required this.title,
    required this.detail,
    required this.isDone,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "titleTodo": title,
        "detailTodo": detail,
        "isDone": isDone,
      };

  static TodoModel fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["id"],
      title: json["titleTodo"],
      detail: json["detailTodo"],
      isDone: json["isDone"],
    );
  }
}
