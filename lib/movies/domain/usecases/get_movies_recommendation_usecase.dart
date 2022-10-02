import 'package:dartz/dartz.dart';
import 'package:second_project/movies/domain/entities/recommendation.dart';
import 'package:second_project/movies/domain/repository/base_movies_repository.dart';

import '../../../core/error/faillure.dart';
import '../entities/movies_details.dart';

class GetMoviesRecommendationUseCase {
  final BaseMoviesRepository baseMoviesRepository;
  GetMoviesRecommendationUseCase({
    required this.baseMoviesRepository,
  });
  Future<Either<Failure, List<Recommendation>>> execute(int id) async {
    return await baseMoviesRepository.getMoviesRecommendations(id);
  }
}
