import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app_flutter/model/quote.dart';

class QuoteRemoteRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Quote>> getAllQuotes() async {
    final snapshot = await _firestore.collection("quotes").get();
    final quotes = snapshot.docs.map((e) => Quote.fromSnapshot(e)).toList();
    return quotes;
  }

  Future<void> uploadAllQuotes(List<Quote> quotes) async {
    final collection = _firestore.collection("quotes");
    final batch = _firestore.batch();
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      batch.delete(doc.reference);
    }
    for (var element in quotes) {
      var docRef = collection.doc();
      batch.set(docRef, element.toJson());
    }
    await batch.commit();
  }
}
