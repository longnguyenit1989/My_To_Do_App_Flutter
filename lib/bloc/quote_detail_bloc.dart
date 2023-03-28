import 'dart:async';

import 'package:flutter/material.dart';

import 'base_bloc.dart';

class QuoteDetailBloc implements BaseBloc {
  final contentController = TextEditingController();
  final authorController = TextEditingController();

  final contentValidationController = StreamController<String>();

  Future<void> updateQuote() async {
    String content = contentController.text;
    if (content.isEmpty) {
      contentValidationController.sink.add("empty");
      return;
    }
    contentValidationController.sink.add("valid");
  }

  @override
  void dispose() {
    contentController.dispose();
    authorController.dispose();
    contentValidationController.close();
  }
}
