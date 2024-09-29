import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/news_model.dart';

class NewsService {
  final String apiKey = 'e72d8a79c8f940379c8532b902172bcd';

  Future<List<News>> fetchNews(String query) async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey'));
    if (response.statusCode == 200) {
      List<dynamic> newsJson = json.decode(response.body)['articles'];
      return newsJson.map((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}