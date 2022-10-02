class Movies {
  final int id;
  final String title;
  final String backdropPath;
  final List<int> genreIds;
  final String overView;

  final double voteAverage;
  final String releaseDate;
  Movies({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.genreIds,
    required this.overView,
    required this.voteAverage,
    required this.releaseDate,
  });
}
