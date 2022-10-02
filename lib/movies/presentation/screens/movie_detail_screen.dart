import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_project/core/constants/app_strings.dart';
import 'package:second_project/core/utils/dummy.dart';
import 'package:second_project/core/utils/enums.dart';
import 'package:second_project/movies/domain/entities/genres.dart';
import 'package:second_project/movies/domain/entities/movies.dart';
import 'package:second_project/movies/domain/entities/movies_details.dart';
import 'package:second_project/movies/domain/entities/recommendation.dart';
import 'package:second_project/movies/presentation/controller/movies_bloc/movies_details_event.dart';
import 'package:second_project/movies/presentation/controller/movies_bloc/movies_details_state.dart';

import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../data/data_source/movies_remote_data_source.dart';
import '../../data/repository/movies_repository.dart';
import '../../domain/repository/base_movies_repository.dart';
import '../../domain/usecases/get_movies_details_usecase.dart';
import '../../domain/usecases/get_movies_recommendation_usecase.dart';
import '../controller/movies_bloc/movies_details_bloc.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;
  final Movies movies;
  const MovieDetailScreen({
    Key? key,
    required this.id,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BaseMoviesRemoteDataSource baseMoviesRemoteDataSource =
        MoviesRemoteDataSource();
    BaseMoviesRepository baseMoviesRepository = MoviesRepository(
        baseMoviesRemoteDataSource: baseMoviesRemoteDataSource);
    return BlocProvider(
      create: (context) => MoviesDetailsBloc(
        GetMoviesDetailsUseCase(
          baseMoviesRepository: baseMoviesRepository,
        ),
        GetMoviesRecommendationUseCase(
            baseMoviesRepository: baseMoviesRepository),
      )..add(GetMoviesRecommendationEvents(id: id)),
      lazy: false,
      child: BlocBuilder<MoviesDetailsBloc, MoviesDetailsState>(
        builder: (context, state) {
          switch (state.requestRecommendationMovies) {
            case RequestState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case RequestState.loaded:
              return Scaffold(
                body: MovieDetailContent(
                  movie: movies,
                  recommendations: state.recommendationMovies,
                ),
              );
            case RequestState.error:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  final Movies movie;
  final List<Recommendation> recommendations;

  const MovieDetailContent({
    Key? key,
    required this.movie,
    required this.recommendations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const Key('movieDetailScrollView'),
      slivers: [
        SliverAppBar(
          title: Text(movie.title,
              maxLines: 1,
              style: GoogleFonts.acme(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              )),
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            background: FadeIn(
              duration: const Duration(milliseconds: 500),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.5, 1.0, 1.0],
                  ).createShader(
                    Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                  );
                },
                blendMode: BlendMode.dstIn,
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  imageUrl: "${AppStrings.baseImageUrl}${movie.backdropPath}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title,
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                      )),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          movie.releaseDate.split('-')[0],
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            (movie.voteAverage / 2).toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '(${movie.voteAverage})',
                            style: const TextStyle(
                              fontSize: 1.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    movie.overView,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
          sliver: SliverToBoxAdapter(
            child: FadeInUp(
              from: 20,
              duration: const Duration(milliseconds: 500),
              child: Text(
                'More like this'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
        // Tab(text: 'More like this'.toUpperCase()),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
          sliver: _showRecommendations(),
        ),
      ],
    );
  }

  String _showGenres(List<Genres> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showRecommendations() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final recommendation = recommendations[index];
          return FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: CachedNetworkImage(
                imageUrl:
                    "${AppStrings.baseImageUrl}${recommendation.backdrop_path}",
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: 170.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 180.0,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        childCount: recommendationDummy.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
        crossAxisCount: 3,
      ),
    );
  }
}
