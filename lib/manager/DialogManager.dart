import 'package:flutter/material.dart';

enum TypeDialog { typeAddItemTodo, typeOption }

class DialogManager {
  var _isShowedDialog = false;

  BuildContext? context;
  var tittle = "";
  TextEditingController? textFieldController;
  bool? canDismiss;
  var message = "";
  var noButtonLabel = "";
  var yesButtonLabel = "";
  Function? callBackNo;
  Function? callBackYes;

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

    this.tittle = tittle;
    this.context = context;
    this.textFieldController = textFieldController;
    this.canDismiss = canDismiss;
    this.message = message ?? "";
    this.noButtonLabel = noButtonLabel ?? "No";
    this.yesButtonLabel = noButtonLabel ?? "Yes";
    this.callBackNo = callBackNo;
    this.callBackYes = callBackYes;

    switch (typeDialog) {
      case TypeDialog.typeAddItemTodo:
        showDialogAddItemTodo();
        break;
      case TypeDialog.typeOption:
        break;
    }
  }

  void showDialogAddItemTodo() {
    showDialog(
        context: context!,
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
                child: Text(yesButtonLabel),
                onPressed: () {
                  if (callBackYes != null) {
                    callBackYes!(textFieldController?.text ?? "");
                  }
                },
              ),
            ],
          );
        }).then((value) {
      _isShowedDialog = false;
    });
  }

  void showDialogOption() {

  }
}
