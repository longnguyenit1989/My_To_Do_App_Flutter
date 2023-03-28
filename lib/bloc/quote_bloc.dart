import 'dart:async';

import '../model/quote.dart';
import '../repository/quote_local_repository.dart';
import 'base_bloc.dart';

class QuoteBloc implements BaseBloc {
  final _quoteLocalRepository = QuoteLocalRepository();

  final List<Quote> quotes = [];
  final quotesController = StreamController<List<Quote>>();
  final navigationController = StreamController<String>.broadcast();

  fetchAllQuotes() async {
    List<Quote> quotes = await _quoteLocalRepository.fetchAllQuotes();
    this.quotes.addAll(quotes);
    print("quotes = ${quotes.length}");
    quotesController.sink.add(quotes);
  }

  insertQuote(Quote quote) async {
    int resultId = await _quoteLocalRepository.insertQuote(quote);
    print("resultId = $resultId");
    if (resultId > 0) {
      quote.id = resultId;
      quotes.add(quote);
      quotesController.sink.add(quotes);
      navigationController.sink.add("add");
    } else {
      // todo: show error
    }
  }

  updateQuote(int index, Quote quote) async {
    int resultId = await _quoteLocalRepository.updateQuote(quote);
    print("resultId = $resultId");
    if (resultId > 0) {
      quotes[index] = quote;
      quotesController.sink.add(quotes);
      navigationController.sink.add("update");
    } else {
      // todo: show error
    }
  }

  deleteQuote(int index, int quoteId) async {
    int resultId = await _quoteLocalRepository.deleteQuote(quoteId);
    print("resultId = $resultId");
    if (resultId > 0) {
      quotes.removeAt(index);
      quotesController.sink.add(quotes);
      navigationController.sink.add("delete");
    } else {
      // todo: show error
    }
  }

  @override
  void dispose() {
    quotesController.close();
    navigationController.close();
  }
}
