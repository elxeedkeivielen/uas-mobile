// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import '../models/verse.dart';
import '../services/bible_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BibleApi _bibleApi = BibleApi();
  List<Verse> _verses = [];
  bool _isLoading = false;
  String? _error;
  final TextEditingController _searchController = TextEditingController();

  void _searchVerses() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final query = _searchController.text.trim();
      final verses = await _bibleApi.fetchVerses(query);
      setState(() {
        _verses = verses;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        print('Error fetching verses: $e');
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
        title: const Text('Home'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _searchVerses,
              child: const Text('Search'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
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
