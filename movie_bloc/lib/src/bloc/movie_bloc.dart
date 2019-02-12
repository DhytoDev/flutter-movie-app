import 'package:movie_bloc/src/bloc/base_bloc.dart';
import 'package:movie_bloc/src/model/movie.dart';
import 'package:movie_bloc/src/model/trailer.dart';
import 'package:movie_bloc/src/repository/movie_repo.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc extends BaseBloc {
  PublishSubject<List<Movie>> _moviesController = PublishSubject<List<Movie>>();
  BehaviorSubject<int> _movieId = BehaviorSubject<int>();
  BehaviorSubject<List<Trailer>> _trailers = BehaviorSubject();

  Sink<List<Movie>> get moviesSink => _moviesController.sink;

  Stream<List<Movie>> get moviesStream => _moviesController.stream;

  Sink<int> get movieId => _movieId.sink;

  Sink<List<Trailer>> get trailersSink => _trailers.sink;

  Stream<List<Trailer>> get trailersStream => _trailers.stream;

  MovieRepo _movieRepo;

  MovieBloc(this._movieRepo) {
    _getMovies();
    _getTrailers();
  }

  void _getMovies() {
    _movieRepo.getNowPlayingMovies().listen(
          (movies) => moviesSink.add(movies),
          onError: (err) => error.add(err.toString()),
        );
  }

  void _getTrailers() {
    _movieId.listen(
        (id) => _movieRepo.getTrailersByMovieId(id).listen(
              (trailers) => trailersSink.add(trailers),
            ),
        onError: (err) => error.add(err.toString()));
  }

  @override
  void dispose() {
    _moviesController.close();
    _movieId.close();
    _trailers.close();
  }
}
