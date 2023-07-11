import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/ui/item_quote.dart';
import 'package:to_do_app_flutter/ui/loading_overlay.dart';
import 'package:to_do_app_flutter/ui/quote_detail.dart';
import 'package:to_do_app_flutter/widgets/dialog.dart';

import '../bloc/quote_bloc.dart';
import '../model/quote.dart';

class QuotesList extends StatefulWidget {
  final QuoteBloc quoteBloc;

  const QuotesList({super.key, required this.quoteBloc});

  @override
  State<StatefulWidget> createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {
  ScrollController? _controller;
  String message = "";

  @override
  void initState() {
    _controller = ScrollController();
    _controller!.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.removeListener(_scrollListener);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      quoteBloc: widget.quoteBloc,
      child: StreamBuilder(
          stream: widget.quoteBloc.quotesController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Quote> quotes = snapshot.data ?? [];
              return RefreshIndicator(
                onRefresh: _pullRefresh,
                child: Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return ItemQuote(
                          quote: quotes[index],
                          onTap: () {
                            // Quote quoteClick = quotes[index];
                            // QuoteDetail quoteDetail = QuoteDetail(
                            //     quoteBloc: widget.quoteBloc,
                            //     index: index,
                            //     quote: quoteClick);
                            // MaterialPageRoute route = MaterialPageRoute(
                            //     builder: (context) => quoteDetail);
                            // Navigator.push(context, route);

                            DialogCustom dialogCustom = DialogCustom();
                            dialogCustom.showMyDialog(typeDialog: TypeDialog.typeRating, context: context, title: 'Dialog rating', message: 'Please rating star');
                          });
                    },
                  ),
                ),
              );
            } else {
              return const Center(child: Text("Hello world!"));
            }
          }),
    );
  }

  Future<void> _pullRefresh() async {
    widget.quoteBloc.fetchAllQuotes();
  }

  _scrollListener() {
    if (_controller!.offset >= _controller!.position.maxScrollExtent &&
        !_controller!.position.outOfRange) {
      message = "reach the bottom";
      widget.quoteBloc.insertQuoteNotSaveSql(Quote.withoutId("o", "o"));
    }
    if (_controller!.offset <= _controller!.position.minScrollExtent &&
        !_controller!.position.outOfRange) {
      message = "reach the top";
    }
  }
}
