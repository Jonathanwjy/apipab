import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = '4474028c146367e48ab5f464d5f5df63';

  Future<List<Map<String, dynamic>>> getAllMovie() async {
    final response =
        await http.get(Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }

  Future<List<Map<String, dynamic>>> getTrendingMovie() async {
    final response = await http
        .get(Uri.parse("$baseUrl/movie/trending/movie/week?api_key=$apiKey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }

  Future<List<Map<String, dynamic>>> getPopularMovie() async {
    final response =
        await http.get(Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }

  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    final response = await http
        .get(Uri.parse("$baseUrl/search/movie?query=$query&api_key=$apiKey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }
}
