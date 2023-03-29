import '../model/quote.dart';
import '../provider/quote_dao.dart';

class QuoteLocalRepository {
  final quoteDao = QuoteDao();

  Future<List<Quote>> fetchAllQuotes() => quoteDao.queryAllRows();

  Future<int> insertQuote(Quote quote) => quoteDao.insertQuote(quote.toMap());

  Future<int> updateQuote(Quote quote) =>
      quoteDao.updateQuote(quote.id, quote.toMap());

  Future<int> deleteQuote(int quoteId) => quoteDao.deleteQuote(quoteId);

  Future<void> deleteAllQuotes() => quoteDao.deleteAllQuotes();

  Future<List<Object?>> insertQuotes(List<Quote> quotes) =>
      quoteDao.insertQuotes(quotes);
}
