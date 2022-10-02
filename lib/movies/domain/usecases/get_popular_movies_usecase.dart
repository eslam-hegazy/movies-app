import 'package:dartz/dartz.dart';
import 'package:second_project/movies/domain/entities/movies.dart';
import 'package:second_project/movies/domain/repository/base_movies_repository.dart';

import '../../../core/error/faillure.dart';

class GetPopularMoviesUseCase {
  final BaseMoviesRepository baseMoviesRepository;
  GetPopularMoviesUseCase({
    required this.baseMoviesRepository,
  });
  Future<Either<Failure, List<Movies>>> execute() async {
    return await baseMoviesRepository.getPopularMovies();
  }
}
