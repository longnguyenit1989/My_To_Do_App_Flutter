import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/bloc/home_viewmodel.dart';
import 'package:to_do_app_flutter/di/di.dart';
import 'package:to_do_app_flutter/manager/DialogManager.dart';
import 'package:to_do_app_flutter/todo_detail.dart';
import 'package:to_do_app_flutter/utils/NotificationService.dart';

import 'database/database_helper.dart';
import 'model/my_todo.dart';
import 'item/todo_item.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  final dbHelper = getIt<DatabaseHelper>();
  final notificationService = getIt<NotificationService>();
  await dbHelper.init();
  await notificationService.initNotification();

  runApp(const TodoApp());
}


class TodoApp extends StatelessWidget {

  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo list',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoList(title: 'Todo App')
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({super.key, required this.title});

  final dialogManager = getIt<DialogManager>();
  final notificationService = getIt<NotificationService>();
  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();

  final homeViewModel = getIt<HomeViewModel>();

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
        children: homeViewModel.getListMyTodo().map((MyTodo myTodo) {
          return TodoItem(
            myTodo: myTodo,
            clickCallBack: _showTodoDetailScreen,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => widget.dialogManager.showMyDialog(
                  TypeDialog.typeAddItemTodo, context, 'Add a new todo item',
                  textFieldController: _textFieldController,
                  yesButtonLabel: "Add",
                  canDismiss: true, callBackYes: (String text) {
                _addTodoItem(text);
                widget.notificationService.showNotification(
                    title: "Add item $text", body: "Success");
              }),
          tooltip: 'Add Item',
          child: const Icon(Icons.add)),
    );
  }

  void _addTodoItem(String name) {
    if (name.trim().isEmpty) {
      return;
    }

    setState(() {
      final int timeNowMilli = DateTime.now().millisecondsSinceEpoch;
      final myTodo = MyTodo(id: timeNowMilli, name: name);
      homeViewModel.insertTodo(myTodo);
    });
    _textFieldController.clear();
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
                    widget.notificationService.showNotification(
                        title: "Delete item ${myTodoParam.name}",
                        body: "Success");
                  },
                  updateItemTodoCallBack: (MyTodo myTodoNew) {
                    _updateTodo(myTodoParam, myTodoNew);
                    widget.notificationService.showNotification(
                        title: "Update item ${myTodoNew.name}",
                        body: "Success");
                  },
                )));
  }

  void _deleteTodo(MyTodo myTodo) {
    setState(() {
      homeViewModel.deleteTodo(myTodo);
    });
  }

  void _updateTodo(MyTodo oldMyTodo, MyTodo newMyTodo) {
    setState(() {
      homeViewModel.updateTodo(oldMyTodo, newMyTodo);
    });
  }

  void getAllMyTodoFromSql() async {
    final result = await homeViewModel.queryAllRows();

    setState(() {
      for (var element in result) {
        final myTodo = MyTodo.fromMap(element);
        homeViewModel.addItemMyTodo(myTodo);
      }
    });
  }
}
