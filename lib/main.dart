import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/manager/DialogManager.dart';
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

  final DialogManager dialogManager = DialogManager();

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
          onPressed: () => dialogManager.showMyDialog(
                  TypeDialog.typeAddItemTodo, context, 'Add a new todo item',
                  textFieldController: _textFieldController,
                  yesButtonLabel: "Add",
                  canDismiss: true, callBackYes: (String text) {
                _addTodoItem(text);
              }),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

  void _addTodoItem(String name) {
    if (name.trim().isEmpty) {
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TodoDetail(title: "Todo detail", myTodo: myTodoParam)));
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

    setState(() {
      result.forEach((element) {
        final myTodo = MyTodo.fromMap(element);
        _listMyTodo.add(myTodo);
      });
    });
  }
}
