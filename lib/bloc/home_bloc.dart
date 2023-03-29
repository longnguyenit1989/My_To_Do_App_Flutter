import 'package:to_do_app_flutter/bloc/base_bloc.dart';

import '../repository/quote_local_repository.dart';
import '../repository/quote_remote_repository.dart';

class HomeBloc implements BaseBloc {
  final _quoteLocalRepository = QuoteLocalRepository();
  final _quoteRemoteRepository = QuoteRemoteRepository();

  syncQuotes() async {
    final remoteQuotes = await _quoteRemoteRepository.getAllQuotes();

    // C1.
    // delete all local
    // insert all from remote
    await _quoteLocalRepository.deleteAllQuotes();
    final resultIds = await _quoteLocalRepository.insertQuotes(remoteQuotes);
    resultIds.forEach((element) {
      print(element);
    });
  }

  @override
  void dispose() {}
}
