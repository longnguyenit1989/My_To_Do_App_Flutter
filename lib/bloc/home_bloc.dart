import 'dart:async';

import 'package:to_do_app_flutter/bloc/base_bloc.dart';

import '../repository/quote_local_repository.dart';
import '../repository/quote_remote_repository.dart';

class HomeBloc implements BaseBloc {
  final _quoteLocalRepository = QuoteLocalRepository();
  final _quoteRemoteRepository = QuoteRemoteRepository();

  final syncAndBackupController = StreamController<String>();

  syncQuotes() async {
    final remoteQuotes = await _quoteRemoteRepository.getAllQuotes();
    await _quoteLocalRepository.deleteAllQuotes();
    await _quoteLocalRepository.insertQuotes(remoteQuotes);
    syncAndBackupController.sink.add('Sync');
  }

  backupQuotes() async {
    final localQuotes = await _quoteLocalRepository.fetchAllQuotes();
    await _quoteRemoteRepository.uploadAllQuotes(localQuotes);
    syncAndBackupController.sink.add('Backup');
  }

  @override
  void dispose() {
    syncAndBackupController.close();
  }
}
