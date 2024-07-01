// lib/models/verse.dart
class Verse {
  final String bookName;
  final int chapter;
  final int verse;
  final String text;

  Verse({
    required this.bookName,
    required this.chapter,
    required this.verse,
    required this.text,
  });

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      bookName: json['book'] ?? json['book_name'] ?? 'Unknown',
      chapter: json['chapter'] ?? 0,
      verse: json['verse'] ?? 0,
      text: json['text'] ?? 'No text available',
    );
  }
}
