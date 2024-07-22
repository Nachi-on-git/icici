// providers/movie_provider.dart
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class MovieProvider with ChangeNotifier {
  final MovieService _movieService = MovieService();
  final List<Movie> _movies = [];
  bool _isLoading = false;
  bool _isFetchingMore = false;
  int _page = 1;
  String _currentSortOrder = 'popular';
  String? _currentQuery;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;

  Future<void> fetchMovies(String sortBy, {bool reset = false}) async {
    if (reset) {
      _page = 1;
      _movies.clear();
      _currentSortOrder = sortBy;
    }

    _isLoading = true;
    notifyListeners();

    try {
      List<Movie> fetchedMovies =
          await _movieService.fetchMovies(sortBy, _page);
      _movies.addAll(fetchedMovies);
      _page++;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchMovies(String query, {bool reset = false}) async {
    if (reset) {
      _page = 1;
      _movies.clear();
      _currentQuery = query;
    }

    _isLoading = true;
    notifyListeners();

    try {
      List<Movie> fetchedMovies =
          await _movieService.searchMovies(query, _page);
      _movies.addAll(fetchedMovies);
      _page++;
    } catch (e) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMoreMovies() async {
    if (_isFetchingMore) return;
    _isFetchingMore = true;
    notifyListeners();

    try {
      List<Movie> fetchedMovies;
      if (_currentQuery != null) {
        fetchedMovies = await _movieService.searchMovies(_currentQuery!, _page);
      } else {
        fetchedMovies =
            await _movieService.fetchMovies(_currentSortOrder, _page);
      }
      _movies.addAll(fetchedMovies);
      _page++;
    } catch (e) {
      // Handle error
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }
}
