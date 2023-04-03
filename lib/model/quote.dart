import 'package:cloud_firestore/cloud_firestore.dart';

import '../provider/db_provider.dart';

class Quote {
  int id = 0;
  String content;
  String? author;

  Quote(this.id, this.content, {this.author});

  Quote.withoutId(this.content, String this.author);

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      DbProvider.columnContent: content,
      DbProvider.columnAuthor: author,
    };
  }

  toJson() {
    return {"content": content, "author": author};
  }

  factory Quote.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Quote(0, data['content'], author: data['author']);
  }

  @override
  String toString() {
    return 'Quote{id: $id, content: $content, author: $author}';
  }
}
