import 'dart:async';

import 'package:core/src/bloc/base_bloc.dart';
import 'package:core/src/domain/interactors/get_now_playing_movies.dart';
import 'package:core/src/model/movie.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc extends BaseBloc {
  PublishSubject<List<Movie>> _moviesController = PublishSubject<List<Movie>>();

  Sink<List<Movie>> get moviesSink => _moviesController.sink;

  Stream<List<Movie>> get moviesStream => _moviesController.stream;

  GetNowPlayingMovies _getNowPlayingMoviesInteractor;

  MovieBloc(this._getNowPlayingMoviesInteractor) {
    _getMovies();
  }

  void _getMovies() {
    _getNowPlayingMoviesInteractor.getNowPlayingMovies().listen(
          (movies) => moviesSink.add(movies),
          onError: (err) => error.add(err.toString()),
        );
  }

  @override
  void dispose() {
    super.dispose();
    _moviesController.close();
  }
}
