import 'package:second_project/movies/domain/entities/movies.dart';

import '../../../../core/utils/enums.dart';

class MoviesState {
  ///////////// Now Playing
  final List<Movies> nowPlayingMovies;
  final RequestState nowPlayingState;
  final String nowPlayingMessage;
  /////////////Popular Playing
  final List<Movies> popularPlayingMovies;
  final RequestState popularPlayingState;
  final String popularPlayingMessage;
  /////////////Top Rating Playing
  final List<Movies> topRatingPlayingMovies;
  final RequestState topRatingPlayingState;
  final String topRatingPlayingMessage;
  MoviesState({
    this.nowPlayingMovies = const [],
    this.nowPlayingState = RequestState.loading,
    this.nowPlayingMessage = '',
    this.popularPlayingMovies = const [],
    this.popularPlayingState = RequestState.loading,
    this.popularPlayingMessage = '',
    this.topRatingPlayingMovies = const [],
    this.topRatingPlayingState = RequestState.loading,
    this.topRatingPlayingMessage = '',
  });
  MoviesState copyWith({
    ///////////// Now Playing
    final List<Movies>? nowPlayingMovies,
    final RequestState? nowPlayingState,
    final String? nowPlayingMessage,
    /////////////Popular Playing
    final List<Movies>? popularPlayingMovies,
    final RequestState? popularPlayingState,
    final String? popularPlayingMessage,
    /////////////Top Rating Playing
    final List<Movies>? topRatingPlayingMovies,
    final RequestState? topRatingPlayingState,
    final String? topRatingPlayingMessage,
  }) {
    return MoviesState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      nowPlayingMessage: nowPlayingMessage ?? this.nowPlayingMessage,
      popularPlayingMovies: popularPlayingMovies ?? this.popularPlayingMovies,
      popularPlayingState: popularPlayingState ?? this.popularPlayingState,
      popularPlayingMessage:
          popularPlayingMessage ?? this.popularPlayingMessage,
      topRatingPlayingMovies:
          topRatingPlayingMovies ?? this.topRatingPlayingMovies,
      topRatingPlayingState:
          topRatingPlayingState ?? this.topRatingPlayingState,
      topRatingPlayingMessage:
          topRatingPlayingMessage ?? this.topRatingPlayingMessage,
    );
  }
}
