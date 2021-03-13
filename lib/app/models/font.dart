class Font {
  final String title;
  final String author;
  final String link;
  final String preview;
  final String info;

  const Font(
      {required this.title,
      required this.author,
      required this.link,
      required this.preview,
      required this.info});

  @override
  String toString() {
    return 'Font(title: $title, author: $author, link: $link, preview: $preview)';
  }

  Font copyWith({
    String? title,
    String? author,
    List<String>? symbols,
    String? link,
    String? preview,
    String? info,
  }) {
    return Font(
        title: title ?? this.title,
        author: author ?? this.author,
        link: link ?? this.link,
        preview: preview ?? this.preview,
        info: info ?? this.info);
  }
}
