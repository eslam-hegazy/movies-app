import 'package:second_project/movies/domain/entities/genres.dart';

class MoviesDetails {
  final int id;
  final String? backdrop_path;
  final List<Genres> generes;
  final String overview;
  final String release_date;
  final int runtime;
  final String title;
  final double vote_average;
  MoviesDetails({
    required this.id,
    this.backdrop_path,
    required this.generes,
    required this.overview,
    required this.release_date,
    required this.runtime,
    required this.title,
    required this.vote_average,
  });
}
