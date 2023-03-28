import '../provider/db_provider.dart';

class Quote {
  int id = 0;
  String content = "";
  String? author;

  Quote(this.id, this.content, this.author);

  Quote.withoutId(this.content, String this.author);

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      DbProvider.columnContent: content,
      DbProvider.columnAuthor: author,
    };
  }

  @override
  String toString() {
    return 'Quote{id: $id, content: $content, author: $author}';
  }
}
