// lib/services/bible_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/verse.dart';

class BibleApi {
  final String baseUrl = 'https://bible-api.com/';

  Future<List<Verse>> fetchVerses(String query) async {
    final response = await http.get(Uri.parse('$baseUrl$query'));

    // Log the URL and status code for debugging
    print('Request URL: ${response.request?.url}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map<String, dynamic> && data.containsKey('verses')) {
        List<dynamic> versesData = data['verses'];
        return versesData.map((json) => Verse.fromJson(json)).toList();
      } else if (data is Map<String, dynamic>) {
        return [Verse.fromJson(data)];
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load verses');
    }
  }
}
