import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_project/core/constants/app_color.dart';
import 'package:second_project/movies/presentation/controller/movies_bloc/movies_bloc.dart';
import 'package:second_project/movies/presentation/controller/movies_bloc/movies_state.dart';
import 'package:second_project/movies/presentation/screens/movies_list_screen.dart';

import 'package:second_project/movies/presentation/view/now_playing_view.dart';
import 'package:second_project/movies/presentation/view/popular_movies_view.dart';
import 'package:second_project/movies/presentation/view/top_rating_view.dart';

import 'package:shimmer/shimmer.dart';

import 'movie_detail_screen.dart';

class MainMoviesScreen extends StatelessWidget {
  const MainMoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
      return Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          key: const Key('movieScrollView'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const NowPlayingView(),
              Container(
                margin: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular",
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                        color: AppColor.kWhite,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return MoviesListScreen(
                            movies: state.popularPlayingMovies,
                            titleAppBar: "Popular Movies",
                          );
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Text(
                              'See More',
                              style: TextStyle(
                                color: AppColor.kWhite,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                              color: AppColor.kWhite,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const PopularMoviesView(),
              Container(
                margin: const EdgeInsets.fromLTRB(
                  16.0,
                  24.0,
                  16.0,
                  8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Rated",
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.15,
                        color: AppColor.kWhite,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return MoviesListScreen(
                            movies: state.topRatingPlayingMovies,
                            titleAppBar: "Top Rated Movies",
                          );
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: const [
                            Text(
                              'See More',
                              style: TextStyle(
                                color: AppColor.kWhite,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16.0,
                              color: AppColor.kWhite,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const TopRatingView(),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      );
    });
  }
}
