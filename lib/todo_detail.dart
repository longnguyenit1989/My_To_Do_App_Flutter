import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/manager/DialogManager.dart';
import 'package:to_do_app_flutter/ui/common/input_text_field_ui.dart';

import 'model/my_todo.dart';

class TodoDetail extends StatefulWidget {
  final String title;
  final MyTodo myTodo;
  final Function() deleteItemTodoCallBack;
  final Function(MyTodo myTodoNew) updateItemTodoCallBack;

  const TodoDetail(
      {Key? key,
      required this.title,
      required this.myTodo,
      required this.deleteItemTodoCallBack,
      required this.updateItemTodoCallBack})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  final TextEditingController _textFieldController = TextEditingController();

  final DialogManager dialogManager = DialogManager();

  @override
  void initState() {
    super.initState();

    setState(() {
      _textFieldController.text = widget.myTodo.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder(builder: (context, snapshot) {
              return InputTextField(
                autofocus: true,
                textFieldController: _textFieldController,
                hintText: "Type your new todo",
              );
            }),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () => {
                      dialogManager.showMyDialog(
                          TypeDialog.typeOptionYesNo, context, "Update dialog",
                          message: "Do you want to update this todo ?",
                          canDismiss: true, callBackYes: () {
                        final newMyTodo = MyTodo(
                            id: widget.myTodo.id,
                            name: _textFieldController.text);
                        widget.updateItemTodoCallBack(newMyTodo);

                        Navigator.pop(context);
                      })
                    },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // Text Color
                ),
                child: const Text("Update")),
            TextButton(
                onPressed: () {
                  dialogManager.showMyDialog(
                      TypeDialog.typeOptionYesNo, context, "Delete dialog",
                      message: "Do you want to delete this todo ?",
                      canDismiss: true, callBackYes: () {
                    widget.deleteItemTodoCallBack();

                    Navigator.pop(context);
                  });
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red, // Text Color
                ),
                child: const Text("Delete")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black54, // Text Color
                ),
                child: const Text("Dismiss"))
          ],
        ),
      ),
    );
  }
}
