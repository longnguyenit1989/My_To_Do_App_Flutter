import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/ui/item_quote.dart';
import 'package:to_do_app_flutter/ui/quote_detail.dart';

import '../bloc/quote_bloc.dart';
import '../model/quote.dart';

class QuotesList extends StatelessWidget {
  final QuoteBloc quoteBloc;

  const QuotesList({super.key, required this.quoteBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: quoteBloc.quotesController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Quote> quotes = snapshot.data ?? [];
            return RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView.builder(
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  return ItemQuote(
                      quote: quotes[index],
                      onTap: () {
                        Quote quoteClick = quotes[index];
                        QuoteDetail quoteDetail = QuoteDetail(
                            quoteBloc: quoteBloc,
                            index: index,
                            quote: quoteClick);
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => quoteDetail);
                        Navigator.push(context, route);
                      });
                },
              ),
            );
          } else {
            return const Center(child: Text("Hello world!"));
          }
        });
  }

  Future<void> _pullRefresh() async {
    quoteBloc.fetchAllQuotes();
  }
}
