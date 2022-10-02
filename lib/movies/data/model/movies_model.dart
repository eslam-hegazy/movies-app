import 'package:second_project/movies/domain/entities/movies.dart';

class MoviesModel extends Movies {
  MoviesModel({
    required super.id,
    required super.title,
    required super.backdropPath,
    required super.genreIds,
    required super.overView,
    required super.voteAverage,
    required super.releaseDate,
  });
  factory MoviesModel.fromJson(Map<String, dynamic> json) => MoviesModel(
        id: json['id'],
        title: json['title'],
        backdropPath: json['backdrop_path'],
        genreIds: List<int>.from(json['genre_ids']..map((e) => e)),
        overView: json['overview'],
        voteAverage: json['vote_average'].toDouble(),
        releaseDate: json['release_date'],
      );
}
