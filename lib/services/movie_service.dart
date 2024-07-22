// services/movie_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieService {
  final String apiKey = '36ef2cf21ff740d132010a5405c04127';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchMovies(String sortBy, int page) async {
    final response = await http
        .get(Uri.parse('$baseUrl/movie/$sortBy?api_key=$apiKey&page=$page'));
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Movie>> searchMovies(String query, int page) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/search/movie?api_key=$apiKey&query=$query&page=$page'));
    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(response.body)['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }
}
