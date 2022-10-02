import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:second_project/core/constants/app_strings.dart';
import 'package:second_project/movies/presentation/screens/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import 'package:second_project/core/constants/app_color.dart';

import '../../domain/entities/movies.dart';

class MoviesListScreen extends StatelessWidget {
  const MoviesListScreen({
    Key? key,
    required this.movies,
    required this.titleAppBar,
  }) : super(key: key);
  final List<Movies> movies;
  final String titleAppBar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppBar),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(1.5.h),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return MovieDetailScreen(
                        id: movies[index].id, movies: movies[index]);
                  }));
                },
                child: moviesItem(moviesData: movies[index]),
              ),
            );
          },
          itemCount: movies.length,
        ),
      ),
    );
  }
}

class moviesItem extends StatelessWidget {
  const moviesItem({
    Key? key,
    required this.moviesData,
  }) : super(key: key);
  final Movies moviesData;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.h,
      padding: EdgeInsets.all(1.5.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.kBlackGrey,
        borderRadius: BorderRadius.circular(2.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: CachedNetworkImage(
                height: 21.h,
                fit: BoxFit.fill,
                imageUrl:
                    "${AppStrings.baseImageUrl}${moviesData.backdropPath}",
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: 21.h,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${moviesData.title}",
                    maxLines: 1,
                    style: GoogleFonts.actor(
                        fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                            color: AppColor.kRed,
                            borderRadius: BorderRadius.circular(1.h)),
                        child: Text(
                          moviesData.releaseDate.split('-')[0],
                          style: GoogleFonts.acme(),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Icon(Icons.star, color: AppColor.kYellow, size: 2.5.h),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        (moviesData.voteAverage / 2).toStringAsFixed(1),
                        style: GoogleFonts.acme(),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    moviesData.overView,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.actor(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
