import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/bloc/home_bloc.dart';
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
  final homeBloc = HomeBloc();

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
          actions: [
            PopupMenuButton(
                itemBuilder: (context) {
                  return {'Backup', 'Sync'}.map((option) {
                    return PopupMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList();
                },
                onSelected: _onOptionMenuSelected)
          ],
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

  void _onOptionMenuSelected(String value) {
    switch (value) {
      case 'Backup':
        // todo add to firestore
        break;
      case 'Sync':
        homeBloc.syncQuotes();
        break;
      default:
    }
  }

  @override
  void dispose() {
    super.dispose();
    quoteBloc.dispose();
    homeBloc.dispose();
  }
}
