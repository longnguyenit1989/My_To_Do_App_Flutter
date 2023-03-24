import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/model/my_todo.dart';

class TodoItem extends StatelessWidget {
  final MyTodo myTodo;
  final Function onTodoChanged;

  TodoItem({required this.myTodo, required this.onTodoChanged}) : super(key: ObjectKey(myTodo));

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) {return null;}

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(myTodo);
      },
      leading: CircleAvatar(
        child: Text(myTodo.name[0]),
      ),
      title: Text(myTodo.name),
    );
  }

}