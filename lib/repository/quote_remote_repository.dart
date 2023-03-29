import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app_flutter/model/quote.dart';

class QuoteRemoteRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Quote>> getAllQuotes() async {
    final snapshot = await _firestore.collection("quotes").get();
    final quotes = snapshot.docs.map((e) => Quote.fromSnapshot(e)).toList();
    return quotes;
  }
}
