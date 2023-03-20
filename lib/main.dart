import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/todo_detail.dart';

import 'database/database_helper.dart';
import 'model/my_todo.dart';
import 'item/todo_item.dart';

final dbHelper = DatabaseHelper();

class Routes {
  static const String todoDetail = "/todo_detail";
  static const String home = "/main";
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  await dbHelper.init();

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(title: 'Todo App'),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});

  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<MyTodo> _listMyTodo = <MyTodo>[];

  @override
  void initState() {
    super.initState();
    getAllMyTodoFromSql();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _listMyTodo.map((MyTodo myTodo) {
          return TodoItem(
            myTodo: myTodo,
            onTodoChanged: _showTodoDetailScreen,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user click out to dismiss dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content: TextField(
            autofocus: true,
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                _addTodoItem(_textFieldController.text);
              },
            ),
          ],
        );
      },
    );
  }

  void _addTodoItem(String name) {
    if (name.isEmpty) {
      return;
    }

    final myTodo = MyTodo(name: name, checked: false);
    _insert(myTodo);

    setState(() {
      _listMyTodo.add(myTodo);
    });
    _textFieldController.clear();

    Navigator.of(context).pop();
  }

  void _handleTodoChange(MyTodo myTodo) {
    setState(() {
      myTodo.checked = !myTodo.checked;
    });
  }

  void _showTodoDetailScreen(MyTodo myTodoParam) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TodoDetail(title: "Todo detail", myTodo: myTodoParam)));
  }

  Future<List<Map<String, dynamic>>> _queryAllRows() async {
    final allRows = await dbHelper.queryAllRows();
    return allRows;
  }

  void _insert(MyTodo myTodo) async {
    final row = myTodo.toMap();
    await dbHelper.insert(row);
  }

  void getAllMyTodoFromSql() async {
    final result = await _queryAllRows();
    result.forEach((element) {
      final myTodo = MyTodo.fromMap(element);
      _listMyTodo.add(myTodo);
    });

    setState(() {});
  }
}
