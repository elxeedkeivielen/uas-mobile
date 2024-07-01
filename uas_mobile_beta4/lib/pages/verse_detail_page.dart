// lib/pages/verse_detail_page.dart
import 'package:flutter/material.dart';
import '../models/verse.dart';

class VerseDetailPage extends StatelessWidget {
  final Verse verse;

  const VerseDetailPage({Key? key, required this.verse}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${verse.bookName} ${verse.chapter}:${verse.verse}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(verse.text),
      ),
    );
  }
}
