class Quote {
  final String id;
  final String content;
  final String author;

  const Quote({
    required this.id,
    required this.content,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': String id,
        'content': String content,
        'author': String author,
      } =>
        Quote(
          id: id,
          content: content,
          author: author,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}