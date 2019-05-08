import 'package:core/core.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class Injection {
  static Injector injector;

  static void initInjection() {
    injector = Injector.getInjector();

    injector.map<MovieRepo>((i) => MovieRepoImpl());
    injector.map<GetNowPlayingMovies>(
        (i) => GetNowPlayingMovies(injector.get<MovieRepo>()));
    injector.map<GetTrailers>((i) => GetTrailers(injector.get<MovieRepo>()));
    injector.map<MovieBloc>(
        (i) => MovieBloc(injector.get<GetNowPlayingMovies>()),
        isSingleton: false);
    injector.map<TrailerBloc>((i) => TrailerBloc(injector.get<GetTrailers>()),
        isSingleton: false);
  }
}
