import 'package:flutter/material.dart';

import '../bloc/quote_bloc.dart';
import '../bloc/quote_detail_bloc.dart';
import '../model/quote.dart';

class QuoteDetail extends StatefulWidget {
  final QuoteBloc quoteBloc;
  final int index;
  final Quote quote;

  const QuoteDetail(
      {super.key,
      required this.index,
      required this.quoteBloc,
      required this.quote});

  @override
  State<QuoteDetail> createState() => _QuoteDetailState();
}

class _QuoteDetailState extends State<QuoteDetail> {
  final QuoteDetailBloc quoteDetailBloc = QuoteDetailBloc();

  void _handleDeleteQuote() {
    AlertDialog alert = AlertDialog(
      content: const Text("Do you want to delete this quote?"),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: const Text("No")),
        TextButton(
            onPressed: () async {
              widget.quoteBloc.deleteQuote(widget.index, widget.quote.id);
            },
            child: const Text("Yes"))
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }

  @override
  void initState() {
    super.initState();
    quoteDetailBloc.contentController.text = widget.quote.content;
    quoteDetailBloc.authorController.text = widget.quote.author ?? "";

    quoteDetailBloc.contentValidationController.stream.listen((event) {
      if (event == 'empty') {
        AlertDialog alert = AlertDialog(
          content: const Text("Please enter content"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"))
          ],
        );
        showDialog(context: context, builder: (context) => alert);
      } else {
        int quoteId = widget.quote.id;
        Quote quote = Quote(quoteId, quoteDetailBloc.contentController.text,
            author: quoteDetailBloc.authorController.text);
        widget.quoteBloc.updateQuote(widget.index, quote);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quote detail"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Content",
                    hintText: "Content"),
                textInputAction: TextInputAction.next,
                controller: quoteDetailBloc.contentController,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Author",
                    hintText: "Author"),
                controller: quoteDetailBloc.authorController,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48)),
                onPressed: () => quoteDetailBloc.updateQuote(),
                child: const Text("Update"),
              ),
              const SizedBox(height: 4),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: const Color.fromARGB(1, 255, 0, 0)),
                onPressed: _handleDeleteQuote,
                child: const Text("Delete"),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    quoteDetailBloc.dispose();
  }
}
