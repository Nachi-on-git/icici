// screens/movie_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.originalTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
              const SizedBox(height: 8),
              const Text('Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(movie.overview),
              const SizedBox(height: 8),
              Text('Rating: ${movie.voteAverage}'),
              Text('Release Date: ${movie.releaseDate}'),
            ],
          ),
        ),
      ),
    );
  }
}
