import 'package:core/core.dart';
import 'package:core/src/domain/repositories/movie_repository.dart';
import 'package:core/src/model/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'use_case.dart';

class GetNowPlayingMovies extends UseCase<MovieRepo, void> {
  BehaviorSubject<List<Movie>> _movies = BehaviorSubject();
  BehaviorSubject<String> _error = BehaviorSubject();

  Stream<List<Movie>> get movies => _movies.stream;

  Stream<String> get error => _error.stream;

  GetNowPlayingMovies(MovieRepo repository) : super(repository);

  @override
  void execute({params}) {
    repository.getNowPlayingMovies().listen(
        (movies) => _movies.sink.add(movies),
        onError: (error) => _error.sink.add(error));
  }

  @override
  void dispose() {
    _movies.close();
    _error.close();
  }
}
