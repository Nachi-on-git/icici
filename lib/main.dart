import 'package:flutter/material.dart';
import 'package:icici/screens/movie_grid.dart';
import 'package:provider/provider.dart';
import 'providers/movie_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MovieProvider(),
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MovieGridScreen(),
      ),
    );
  }
}
