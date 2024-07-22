// widgets/movie_grid_item.dart
import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/movie_detail.dart';

class MovieGridItem extends StatelessWidget {
  final Movie movie;

  const MovieGridItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(movie.title),
          ),
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
