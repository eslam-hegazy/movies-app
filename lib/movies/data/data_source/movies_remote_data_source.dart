import 'package:dio/dio.dart';
import 'package:second_project/core/error/server_exception.dart';
import 'package:second_project/core/network/error_message_model.dart';
import 'package:second_project/movies/data/model/movies_details_model.dart';
import 'package:second_project/movies/data/model/recommendation_model.dart';

import '../../../core/constants/app_strings.dart';
import '../model/movies_model.dart';

abstract class BaseMoviesRemoteDataSource {
  Future<List<MoviesModel>> getNowPlayingMovies();
  Future<List<MoviesModel>> getPopularMovies();
  Future<List<MoviesModel>> getTopRateMovies();
  Future<MoviesDetailsModel> getMoviesDetails(int id);
  Future<List<RecommendationModel>> getRecommendationMovies(int id);
}

class MoviesRemoteDataSource extends BaseMoviesRemoteDataSource {
  @override
  Future<List<MoviesModel>> getNowPlayingMovies() async {
    var response = await Dio().get(
        '${AppStrings.baseUrl}${AppStrings.nowPlayingMovies}api_key=${AppStrings.apiKey}');

    if (response.statusCode == 200) {
      return List<MoviesModel>.from(
        (response.data['results'] as List).map(
          (e) => MoviesModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MoviesModel>> getPopularMovies() async {
    var response = await Dio().get(
        '${AppStrings.baseUrl}${AppStrings.popularMovies}api_key=${AppStrings.apiKey}');
    if (response.statusCode == 200) {
      return List<MoviesModel>.from(
        (response.data['results'] as List).map(
          (e) => MoviesModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<MoviesModel>> getTopRateMovies() async {
    var response = await Dio().get(
        '${AppStrings.baseUrl}${AppStrings.topRatingMovies}api_key=${AppStrings.apiKey}');
    if (response.statusCode == 200) {
      return List<MoviesModel>.from(
        (response.data['results'] as List).map(
          (e) => MoviesModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<MoviesDetailsModel> getMoviesDetails(int id) async {
    var response = await Dio().get(
        '${AppStrings.baseUrl}${AppStrings.moviesDetails}$id?api_key=${AppStrings.apiKey}');
    print(response.data);
    if (response.statusCode == 200) {
      return MoviesDetailsModel.fromJson(response.data['results']);
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<RecommendationModel>> getRecommendationMovies(int id) async {
    var response = await Dio().get(
        '${AppStrings.baseUrl}${AppStrings.moviesDetails}$id/recommendations?api_key=${AppStrings.apiKey}');
    if (response.statusCode == 200) {
      return List<RecommendationModel>.from(
        (response.data['results'] as List).map(
          (e) => RecommendationModel.fromJson(e),
        ),
      );
    } else {
      throw ServerExceptions(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
