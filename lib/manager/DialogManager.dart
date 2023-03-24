import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

enum TypeDialog { typeAddItemTodo, typeOptionYesNo }

@Singleton()
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
    this.yesButtonLabel = yesButtonLabel ?? "Yes";
    this.callBackNo = callBackNo;
    this.callBackYes = callBackYes;

    switch (typeDialog) {
      case TypeDialog.typeAddItemTodo:
        _showDialogAddItemTodo();
        break;
      case TypeDialog.typeOptionYesNo:
        _showDialogOptionYesNo();
        break;
    }
  }

  void _showDialogAddItemTodo() {
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
                onPressed: () {
                  if (callBackYes != null) {
                    callBackYes!(textFieldController?.text ?? "");
                  }
                  _dismissCurrentDialog();
                },
                child: Text(yesButtonLabel),
              ),
            ],
          );
        }).then((value) {
      _isShowedDialog = false;
    });
  }

  void _showDialogOptionYesNo() {
    showDialog(
        context: context!,
        barrierDismissible: canDismiss ?? false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tittle),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    if (callBackNo != null) {
                      callBackNo!();
                    }
                    _dismissCurrentDialog();
                  },
                  child: Text(noButtonLabel)),
              TextButton(
                  onPressed: () {
                    if (callBackYes != null) {
                      callBackYes!();
                    }
                    _dismissCurrentDialog();
                  },
                  child: Text(yesButtonLabel))
            ],
          );
        }).then((value) {
      _isShowedDialog = false;
    });
  }

  void _dismissCurrentDialog() {
    if (context != null) {
      Navigator.of(context!).pop();
    }
  }
}
