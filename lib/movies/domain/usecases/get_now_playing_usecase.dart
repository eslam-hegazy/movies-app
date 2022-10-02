import 'package:dartz/dartz.dart';
import 'package:second_project/movies/domain/entities/movies.dart';
import 'package:second_project/movies/domain/repository/base_movies_repository.dart';

import '../../../core/error/faillure.dart';

class GetNowPlayingUseCase {
  final BaseMoviesRepository baseMoviesRepository;
  GetNowPlayingUseCase({
    required this.baseMoviesRepository,
  });
  Future<Either<Failure, List<Movies>>> execute() async {
    return await baseMoviesRepository.getNowPlaying();
  }
}
