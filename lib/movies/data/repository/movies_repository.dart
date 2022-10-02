import 'package:dartz/dartz.dart';
import 'package:second_project/core/error/faillure.dart';
import 'package:second_project/core/error/server_exception.dart';
import 'package:second_project/movies/data/data_source/movies_remote_data_source.dart';
import 'package:second_project/movies/domain/entities/movies.dart';
import 'package:second_project/movies/domain/entities/movies_details.dart';
import 'package:second_project/movies/domain/entities/recommendation.dart';
import 'package:second_project/movies/domain/repository/base_movies_repository.dart';

class MoviesRepository extends BaseMoviesRepository {
  final BaseMoviesRemoteDataSource baseMoviesRemoteDataSource;
  MoviesRepository({
    required this.baseMoviesRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<Movies>>> getNowPlaying() async {
    final result = await baseMoviesRemoteDataSource.getNowPlayingMovies();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.status_message));
    }
  }

  @override
  Future<Either<Failure, List<Movies>>> getPopularMovies() async {
    final result = await baseMoviesRemoteDataSource.getPopularMovies();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.status_message));
    }
  }

  @override
  Future<Either<Failure, List<Movies>>> getTopRatedMovies() async {
    final result = await baseMoviesRemoteDataSource.getTopRateMovies();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.status_message));
    }
  }

  @override
  Future<Either<Failure, MoviesDetails>> getMoviesDetails(int id) async {
    final result = await baseMoviesRemoteDataSource.getMoviesDetails(id);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.status_message));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getMoviesRecommendations(
      int id) async {
    final result = await baseMoviesRemoteDataSource.getRecommendationMovies(id);
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(
          ServerFailure(message: failure.errorMessageModel.status_message));
    }
  }
}
