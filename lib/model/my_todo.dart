class MyTodo {
  MyTodo({required this.name, required this.checked});

  final String name;
  bool checked;

  Map<String, dynamic> toMap() {
    return {"name": name, "checked": checked ? 1 : 0};
  }

  static MyTodo fromMap(Map<String, dynamic> map) {
    final checkedNumber = map["checked"] as int;
    var checkedBool = false;
    if (checkedNumber == 0) {
      checkedBool = false;
    } else {
      checkedBool = true;
    }
    return MyTodo(name: map["name"], checked: checkedBool);
  }
}
