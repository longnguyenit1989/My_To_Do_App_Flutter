import 'package:flutter/material.dart';

enum TypeDialog { typeAddItemTodo, typeOption }

class DialogManager {
  var _isShowedDialog = false;

  DialogManager();

  void showMyDialog(TypeDialog typeDialog, BuildContext context, String tittle,
      {TextEditingController? textFieldController,
      bool? canDismiss,
      String? message,
      String? noButtonLabel,
      String? yesButtonLabel,
      Function? callBackNo,
      Function? callBackYes}) {
    if (_isShowedDialog) {
      return;
    }
    _isShowedDialog = true;

    switch (typeDialog) {
      case TypeDialog.typeAddItemTodo:
        showDialogAddItemTodo(context, tittle, textFieldController, true,
            message, yesButtonLabel, callBackYes);
        break;
      case TypeDialog.typeOption:
        break;
    }
  }

  void showDialogAddItemTodo(
      BuildContext context,
      String tittle,
      TextEditingController? textFieldController,
      bool? canDismiss,
      String? message,
      String? yesButtonLabel,
      Function? callBackYes) {
    showDialog(
        context: context,
        barrierDismissible: canDismiss ?? false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tittle),
            content: TextField(
              autofocus: true,
              controller: textFieldController,
              decoration: const InputDecoration(hintText: 'Type your new todo'),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(yesButtonLabel ?? "Yes"),
                onPressed: () {
                  if (callBackYes != null) {
                    callBackYes(textFieldController?.text ?? "");
                  }
                },
              ),
            ],
          );
        }).then((value) {
      _isShowedDialog = false;
    });
  }
}
