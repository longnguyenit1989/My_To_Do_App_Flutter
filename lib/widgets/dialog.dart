import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:to_do_app_flutter/widgets/half_filled_icon.dart';

enum TypeDialog { typeOptionYes, typeOptionYesNo, typeRating }

class DialogCustom {
  DialogCustom();

  var _isShowedDialog = false;

  BuildContext? context;
  String title = '';
  bool? canDismiss;
  String message = '';
  String noButtonLabel = '';
  String yesButtonLabel = '';
  void Function()? callBackNo;
  void Function()? callBackYes;

  void showMyDialog({
    required TypeDialog typeDialog,
    required BuildContext context,
    required String title,
    bool? canDismiss,
    String? message,
    String? noButtonLabel,
    String? yesButtonLabel,
    void Function()? callBackNo,
    void Function()? callBackYes,
  }) {
    if (_isShowedDialog) {
      return;
    }
    _isShowedDialog = true;

    this.title = title;
    this.context = context;
    this.canDismiss = canDismiss;
    this.message = message ?? '';
    this.noButtonLabel = noButtonLabel ?? 'No';
    this.yesButtonLabel = yesButtonLabel ?? 'Yes';
    this.callBackNo = callBackNo;
    this.callBackYes = callBackYes;

    switch (typeDialog) {
      case TypeDialog.typeOptionYes:
        _showDialogOptionYes();
        break;
      case TypeDialog.typeOptionYesNo:
        _showDialogOptionYesNo();
        break;
      case TypeDialog.typeRating:
        _showDialogRating();
        break;
    }
  }

  void _showDialogOptionYes() {
    showDialog<void>(
      context: context!,
      barrierDismissible: canDismiss ?? false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                callBackYes?.call();
                _dismissCurrentDialog();
              },
              child: Text(yesButtonLabel),
            ),
          ],
        );
      },
    ).then((value) {
      _isShowedDialog = false;
    });
  }

  void _showDialogOptionYesNo() {
    showDialog<void>(
      context: context!,
      barrierDismissible: canDismiss ?? false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                callBackNo?.call();
                _dismissCurrentDialog();
              },
              child: Text(noButtonLabel),
            ),
            TextButton(
              onPressed: () {
                callBackYes?.call();
                _dismissCurrentDialog();
              },
              child: Text(yesButtonLabel),
            )
          ],
        );
      },
    ).then((value) {
      _isShowedDialog = false;
    });
  }

  void _showDialogRating() {
    Dialog ratingDialog = Dialog(
      // insetPadding: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            const SizedBox(
              height: 40,
            ),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(
              height: 10,
            ),
            RatingBar(
              initialRating: 3,
              minRating: 1,
              maxRating: 5,
              itemSize: 40,
              direction: Axis.horizontal,
              allowHalfRating: true,
              onRatingUpdate: (rating) {},
              ratingWidget: RatingWidget(
                full: const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                empty: const Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
                half: const HalfFilledIcon(
                    icon: Icons.star, size: 40, color: Colors.amber),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    callBackNo?.call();
                    _dismissCurrentDialog();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: const Size(110, 40)),
                  child: Text(noButtonLabel),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      callBackYes?.call();
                      _dismissCurrentDialog();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(110, 40)),
                    child: Text(yesButtonLabel))
              ],
            )
          ],
        ),
      ),
    );

    showDialog<void>(
        context: context!,
        barrierDismissible: canDismiss ?? false,
        builder: (BuildContext context) => ratingDialog).then((value) {
      _isShowedDialog = false;
    });
  }

  void _dismissCurrentDialog() {
    if (context != null) {
      Navigator.of(context!).pop();
    }
  }
}
