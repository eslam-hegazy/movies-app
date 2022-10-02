import 'package:dartz/dartz.dart';
import 'package:second_project/movies/domain/entities/movies_details.dart';
import 'package:second_project/movies/domain/repository/base_movies_repository.dart';

import '../../../core/error/faillure.dart';

class GetMoviesDetailsUseCase {
  final BaseMoviesRepository baseMoviesRepository;
  GetMoviesDetailsUseCase({
    required this.baseMoviesRepository,
  });
  Future<Either<Failure, MoviesDetails>> execute(int id) async {
    return await baseMoviesRepository.getMoviesDetails(id);
  }
}
