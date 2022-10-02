abstract class MoviesDetailsEvent {}

class GetMoviesDetailsEvent extends MoviesDetailsEvent {
  final int id;
  GetMoviesDetailsEvent({
    required this.id,
  });
}

class GetMoviesRecommendationEvents extends MoviesDetailsEvent {
  final int id;
  GetMoviesRecommendationEvents({
    required this.id,
  });
}
