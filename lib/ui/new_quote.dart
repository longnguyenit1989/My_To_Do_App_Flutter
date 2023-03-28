import 'package:flutter/material.dart';

import '../bloc/new_quote_bloc.dart';
import '../bloc/quote_bloc.dart';
import '../model/quote.dart';

class NewQuote extends StatefulWidget {
  final QuoteBloc quoteBloc;

  const NewQuote({super.key, required this.quoteBloc});

  @override
  State<NewQuote> createState() => _NewQuoteState();
}

class _NewQuoteState extends State<NewQuote> {
  final NewQuoteBloc newQuoteBloc = NewQuoteBloc();

  @override
  void initState() {
    super.initState();
    newQuoteBloc.contentValidationController.stream.listen((event) {
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
        Quote quote = Quote.withoutId(newQuoteBloc.contentController.text,
            newQuoteBloc.authorController.text);
        widget.quoteBloc.insertQuote(quote);
      }
    });

    widget.quoteBloc.navigationController.stream
        .asBroadcastStream()
        .listen((event) {
      if (event == "add") {
        if (mounted) {
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("New quotes"),
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
                controller: newQuoteBloc.contentController,
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Author",
                    hintText: "Author"),
                controller: newQuoteBloc.authorController,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(48)),
                onPressed: () => newQuoteBloc.newQuote(),
                child: const Text("Create"),
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    newQuoteBloc.dispose();
  }
}
