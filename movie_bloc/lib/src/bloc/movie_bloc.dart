import 'package:movie_bloc/src/bloc/base_bloc.dart';
import 'package:movie_bloc/src/model/movie.dart';
import 'package:movie_bloc/src/repository/movie_repo.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc extends BaseBloc {
  PublishSubject<List<Movie>> _moviesController = PublishSubject<List<Movie>>();

  Sink<List<Movie>> get moviesSink => _moviesController.sink;

  Stream<List<Movie>> get moviesStream => _moviesController.stream;

  MovieRepo _movieRepo;

  MovieBloc(this._movieRepo) {
    _getMovies();
  }

  void _getMovies() {
    _movieRepo.getMovies().listen(
          (movies) => moviesSink.add(movies),
          onError: (err) => error.add(err),
        );
  }

  @override
  void dispose() {
    _moviesController.close();
  }
}
