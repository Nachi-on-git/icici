// screens/movie_grid_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_grid_item.dart';

class MovieGridScreen extends StatefulWidget {
  const MovieGridScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MovieGridScreenState createState() => _MovieGridScreenState();
}

class _MovieGridScreenState extends State<MovieGridScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final movieProvider = Provider.of<MovieProvider>(context, listen: false);
      movieProvider.fetchMovies('popular');
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        final movieProvider =
            Provider.of<MovieProvider>(context, listen: false);
        movieProvider.fetchMoreMovies();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App By Nachiket'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              final movieProvider =
                  Provider.of<MovieProvider>(context, listen: false);
              movieProvider.fetchMovies(value, reset: true);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'popular',
                child: Text('Most Popular'),
              ),
              const PopupMenuItem(
                value: 'top_rated',
                child: Text('Highest Rated'),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.isLoading && movieProvider.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              GridView.builder(
                controller: _scrollController,
                itemCount: movieProvider.movies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final movie = movieProvider.movies[index];
                  return MovieGridItem(movie: movie);
                },
              ),
              if (movieProvider.isFetchingMore)
                Positioned(
                  bottom: 16,
                  left: MediaQuery.of(context).size.width / 2 - 16,
                  child: const CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}

class MovieSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieProvider.searchMovies(query, reset: true);
    });
    return Consumer<MovieProvider>(
      builder: (context, movieProvider, child) {
        if (movieProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          itemCount: movieProvider.movies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final movie = movieProvider.movies[index];
            return MovieGridItem(movie: movie);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
