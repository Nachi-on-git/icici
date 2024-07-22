// models/movie.dart
class Movie {
  final String originalTitle;
  final String posterPath;
  final String overview;
  final double voteAverage;
  final String releaseDate;
  final String title;

  Movie({
    required this.originalTitle,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      originalTitle: json['original_title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      voteAverage: json['vote_average'].toDouble(),
      releaseDate: json['release_date'],
      title: json['title'],
    );
  }
}
