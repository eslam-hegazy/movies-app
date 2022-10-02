import 'package:second_project/movies/data/model/genres_model.dart';
import 'package:second_project/movies/domain/entities/movies_details.dart';

class MoviesDetailsModel extends MoviesDetails {
  MoviesDetailsModel({
    required super.id,
    super.backdrop_path,
    required super.generes,
    required super.overview,
    required super.release_date,
    required super.runtime,
    required super.title,
    required super.vote_average,
  });
  factory MoviesDetailsModel.fromJson(Map<String, dynamic> json) =>
      MoviesDetailsModel(
        id: json['id'],
        backdrop_path:
            json['backdrop_path'] ?? "/2k9tBql5GYH328Krj66tDT9LtFZ.jpg",
        generes: List.from(json['genres'].map((x) => GenresModel.fromJson(x))),
        overview: json['overview'],
        release_date: json['release_date'],
        runtime: json['runtime'],
        title: json['title'],
        vote_average: json['vote_average'],
      );
}
