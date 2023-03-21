import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/ui/common/input_text_field_ui.dart';

import 'model/my_todo.dart';

class TodoDetail extends StatefulWidget {
  final String title;
  final MyTodo myTodo;

  const TodoDetail({Key? key, required this.title, required this.myTodo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {
  final TextEditingController _textFieldController = TextEditingController();

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
                onPressed: () => {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue, // Text Color
                ),
                child: const Text("Update")),
            TextButton(
                onPressed: () => {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red, // Text Color
                ),
                child: const Text("Delete")),
            TextButton(
                onPressed: () => {Navigator.pop(context)},
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
