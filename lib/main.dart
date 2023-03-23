import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/manager/DialogManager.dart';
import 'package:to_do_app_flutter/todo_detail.dart';
import 'package:to_do_app_flutter/utils/NotificationService.dart';

import 'database/database_helper.dart';
import 'model/my_todo.dart';
import 'item/todo_item.dart';

final dbHelper = DatabaseHelper();
final NotificationService notificationService = NotificationService();

class Routes {
  static const String todoDetail = "/todo_detail";
  static const String home = "/main";
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize the database
  await dbHelper.init();
  notificationService.initNotification();

  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  final MyTodo? myTodo = null;

  const TodoApp({super.key, myTodo});

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
                notificationService.showNotification(title: "Add item $text", body: "Success");
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
            builder: (context) => TodoDetail(
                  title: "Todo detail",
                  myTodo: myTodoParam,
                  deleteItemTodoCallBack: () {
                    _deleteTodo(myTodoParam);
                    notificationService.showNotification(title: "Delete item ${myTodoParam.name}", body: "Success");
                  },
                  updateItemTodoCallBack: (MyTodo myTodoNew) {
                    _updateTodo(myTodoParam, myTodoNew);
                    notificationService.showNotification(title: "Update item ${myTodoNew.name}", body: "Success");
                  },
                )));
  }

  Future<List<Map<String, dynamic>>> _queryAllRows() async {
    final allRows = await dbHelper.queryAllRows();
    return allRows;
  }

  void _insert(MyTodo myTodo) async {
    final row = myTodo.toMap();
    await dbHelper.insert(row);
  }

  void _deleteTodo(MyTodo myTodo) async {
    await dbHelper.delete(myTodo.name);

    setState(() {
      _listMyTodo.remove(myTodo);
    });
  }

  void _updateTodo(MyTodo oldMyTodo, MyTodo newMyTodo) async {
    await dbHelper.updateFollowName(oldMyTodo.name, newMyTodo.name);

    setState(() {
      final indexNeedUpdate = _listMyTodo.indexOf(oldMyTodo);
      _listMyTodo.replaceRange(indexNeedUpdate, indexNeedUpdate + 1, [newMyTodo]);
    });
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
