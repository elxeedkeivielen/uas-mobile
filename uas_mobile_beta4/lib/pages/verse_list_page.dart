// lib/pages/verse_list_page.dart
import 'package:flutter/material.dart';
import '../models/verse.dart';
import '../services/bible_api.dart';

class VerseListPage extends StatefulWidget {
  const VerseListPage({Key? key}) : super(key: key);

  @override
  _VerseListPageState createState() => _VerseListPageState();
}

class _VerseListPageState extends State<VerseListPage> {
  final TextEditingController _controller = TextEditingController();
  final BibleApi _bibleApi = BibleApi();
  List<Verse> _verses = [];
  bool _isLoading = false;
  String? _error;

  void _searchVerses() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final verses = await _bibleApi.fetchVerses(_controller.text);
      setState(() {
        _verses = verses;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Verses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Search'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _searchVerses,
              child: _isLoading ? CircularProgressIndicator() : Text('Search'),
            ),
            SizedBox(height: 20),
            _error != null
                ? Text(_error!, style: TextStyle(color: Colors.red))
                : Expanded(
              child: ListView.builder(
                itemCount: _verses.length,
                itemBuilder: (context, index) {
                  final verse = _verses[index];
                  return ListTile(
                    title: Text('${verse.bookName} ${verse.chapter}:${verse.verse}'),
                    subtitle: Text(verse.text),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
