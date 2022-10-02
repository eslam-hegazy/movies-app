import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/core/utils/dummy.dart';
import 'package:second_project/core/utils/enums.dart';
import 'package:second_project/movies/presentation/controller/movies_bloc/movies_bloc.dart';
import 'package:second_project/movies/presentation/controller/movies_bloc/movies_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/constants/app_strings.dart';
import '../screens/movie_detail_screen.dart';

class TopRatingView extends StatelessWidget {
  const TopRatingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        print("Top Rating");
        switch (state.topRatingPlayingState) {
          case RequestState.loading:
            return Container(
              alignment: Alignment.center,
              height: 170,
              child: const CircularProgressIndicator(),
            );
          case RequestState.loaded:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: SizedBox(
                height: 170.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: state.topRatingPlayingMovies.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return MovieDetailScreen(
                              id: state.topRatingPlayingMovies[index].id,
                              movies: state.topRatingPlayingMovies[index],
                            );
                          }));
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          child: CachedNetworkImage(
                            width: 120.0,
                            fit: BoxFit.cover,
                            imageUrl:
                                "${AppStrings.baseImageUrl}${state.topRatingPlayingMovies[index].backdropPath}",
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
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          case RequestState.error:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
