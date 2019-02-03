import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:movie_bloc/src/bloc/movie_bloc.dart';
import 'package:movie_bloc/src/repository/movie_repo.dart';

class Injection {
  static Injector injector;

  static void initInjection() {
    injector = Injector.getInjector();

    injector.map<MovieRepo>((i) => MovieRepoImpl());
    injector.map<MovieBloc>((i) => MovieBloc(injector.get<MovieRepo>()),
        isSingleton: false);
  }
}
