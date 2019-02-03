import 'dart:async';

import 'package:flutter_movie_app/data/bloc/bloc_provider.dart';
import 'package:flutter_movie_app/data/model/movie_response.dart';
import 'package:flutter_movie_app/data/model/trailer.dart';
import 'package:flutter_movie_app/data/repository/movie_repo.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc implements BlocBase {
  PublishSubject<List<Movie>> _moviesController = PublishSubject<List<Movie>>();

  Sink<List<Movie>> get _inMoviesList => _moviesController.sink;

  Stream<List<Movie>> get outMoviesList => _moviesController.stream;

  BehaviorSubject<int> _movieId = BehaviorSubject<int>();

  Sink<int> get movieId => _movieId.sink;

  Stream<List<Trailer>> _trailers = Stream.empty();

  Stream<List<Trailer>> get trailers => _trailers;

  StreamController _controller = StreamController();

  MovieBloc() {
    _handleFetchedPage();

    _trailers = _movieId
        .distinct()
        .asyncMap((id) => movieRepo.fetchMovieTrailers(id))
        .asBroadcastStream();
  }

  @override
  void dispose() {
    _moviesController.close();
    _movieId.close();
    _controller.close();
  }

  void _handleFetchedPage() {
    List<Movie> movies = [];

    movieRepo.fetchUpcomingMovies().then((response) {
      movies.addAll(response.movies);
      if (movies.length > 0) {
        _inMoviesList.add(movies);
      }
    });
  }
}
