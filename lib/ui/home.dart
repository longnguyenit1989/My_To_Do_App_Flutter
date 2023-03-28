import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/ui/quotes_list.dart';

import '../bloc/quote_bloc.dart';
import 'new_quote.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final quoteBloc = QuoteBloc();

  @override
  void initState() {
    super.initState();
    quoteBloc.fetchAllQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quotes"),
        ),
        body: QuotesList(quoteBloc: quoteBloc),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewQuote(quoteBloc: quoteBloc)));
          },
          child: const Icon(Icons.add),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    quoteBloc.dispose();
  }
}
