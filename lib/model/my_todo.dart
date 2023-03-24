import '../database/database_helper.dart';

class MyTodo {
  MyTodo({this.id, required this.name});

  int? id;
  String name;

  Map<String, dynamic> toMap() {
    return {DatabaseHelper.columnId: id, DatabaseHelper.columnName: name};
  }

  static MyTodo fromMap(Map<String, dynamic> map) {
    return MyTodo(id: map[DatabaseHelper.columnId], name: map[DatabaseHelper.columnName]);
  }
}
