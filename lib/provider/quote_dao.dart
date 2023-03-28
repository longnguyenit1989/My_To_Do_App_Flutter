import '../model/quote.dart';
import 'db_provider.dart';

class QuoteDao {
  final quoteProvider = DbProvider.dbProvider;

  Future<List<Quote>> queryAllRows() async {
    final quoteDb = await quoteProvider.database;
    final List<Map<String, dynamic>> quotes =
        await quoteDb.query(DbProvider.tableQuote);
    return List.generate(quotes.length, (i) {
      return Quote(
        quotes[i][DbProvider.columnId],
        quotes[i][DbProvider.columnContent],
        quotes[i][DbProvider.columnAuthor],
      );
    });
  }

  Future<int> insertQuote(Map<String, dynamic> values) async {
    final quoteDb = await quoteProvider.database;
    return await quoteDb.insert(DbProvider.tableQuote, values);
  }

  Future<int> updateQuote(int id, Map<String, dynamic> values) async {
    final quoteDb = await quoteProvider.database;
    return await quoteDb.update(DbProvider.tableQuote, values,
        where: '${DbProvider.columnId} = ?', whereArgs: [id]);
  }

  Future<int> deleteQuote(int id) async {
    final quoteDb = await quoteProvider.database;
    return await quoteDb.delete(DbProvider.tableQuote,
        where: '${DbProvider.columnId} = ?', whereArgs: [id]);
  }
}
