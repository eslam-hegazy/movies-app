import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/core/constants/app_color.dart';
import 'package:second_project/movies/domain/usecases/get_movies_details_usecase.dart';
import 'package:second_project/movies/domain/usecases/get_movies_recommendation_usecase.dart';
import 'package:second_project/movies/domain/usecases/get_now_playing_usecase.dart';
import 'package:second_project/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:second_project/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:second_project/movies/presentation/controller/movies_bloc/movies_bloc.dart';
import 'package:second_project/movies/presentation/controller/movies_bloc/movies_details_bloc.dart';
import 'package:second_project/movies/presentation/controller/movies_bloc/movies_event.dart';
import 'package:second_project/movies/presentation/screens/splash_screen.dart';
import 'package:sizer/sizer.dart';
import 'movies/data/data_source/movies_remote_data_source.dart';
import 'movies/data/repository/movies_repository.dart';
import 'movies/domain/repository/base_movies_repository.dart';
import 'movies/presentation/controller/MyBlocObserver.dart';
import 'movies/presentation/screens/movies_screen.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      BaseMoviesRemoteDataSource baseMoviesRemoteDataSource =
          MoviesRemoteDataSource();
      BaseMoviesRepository baseMoviesRepository = MoviesRepository(
          baseMoviesRemoteDataSource: baseMoviesRemoteDataSource);
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MoviesBloc(
              GetNowPlayingUseCase(baseMoviesRepository: baseMoviesRepository),
              GetPopularMoviesUseCase(
                  baseMoviesRepository: baseMoviesRepository),
              GetTopRateMoviesUseCase(
                  baseMoviesRepository: baseMoviesRepository),
            )
              ..add(GetNowPlayingEvent())
              ..add(GetPopularMoviesEvent())
              ..add(GetTopRatedEvent()),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => MoviesDetailsBloc(
              GetMoviesDetailsUseCase(
                baseMoviesRepository: baseMoviesRepository,
              ),
              GetMoviesRecommendationUseCase(
                  baseMoviesRepository: baseMoviesRepository),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.grey.shade900,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: AppColor.kBlack,
            ),
          ),
          home: const SplashScreen(),
        ),
      );
    });
  }
}
