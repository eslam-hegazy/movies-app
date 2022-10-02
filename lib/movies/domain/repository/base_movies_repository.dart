import 'package:dartz/dartz.dart';
import 'package:second_project/movies/domain/entities/movies.dart';
import 'package:second_project/movies/domain/entities/movies_details.dart';
import 'package:second_project/movies/domain/entities/recommendation.dart';

import '../../../core/error/faillure.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, List<Movies>>> getNowPlaying();
  Future<Either<Failure, List<Movies>>> getPopularMovies();
  Future<Either<Failure, List<Movies>>> getTopRatedMovies();
  Future<Either<Failure, MoviesDetails>> getMoviesDetails(int id);
  Future<Either<Failure, List<Recommendation>>> getMoviesRecommendations(
      int id);
}
