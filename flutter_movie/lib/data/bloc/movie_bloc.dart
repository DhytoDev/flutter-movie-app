import 'dart:async';

import 'package:flutter_movie_app/data/bloc/bloc_provider.dart';
import 'package:flutter_movie_app/data/model/trailer.dart';
import 'package:flutter_movie_app/data/repository/movie_repo.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc implements BlocBase {
  BehaviorSubject<int> _movieId = BehaviorSubject<int>();

  Sink<int> get movieId => _movieId.sink;

  Stream<List<Trailer>> _trailers = Stream.empty();

  Stream<List<Trailer>> get trailers => _trailers;

  StreamController _controller = StreamController();

  MovieBloc() {
    _trailers = _movieId
        .distinct()
        .asyncMap((id) => movieRepo.fetchMovieTrailers(id))
        .asBroadcastStream();
  }

  @override
  void dispose() {
    _movieId.close();
    _controller.close();
  }
}
