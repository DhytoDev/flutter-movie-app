import 'package:core/src/bloc/base_bloc.dart';
import 'package:core/src/domain/interactors/get_now_playing_movies.dart';
import 'package:core/src/domain/interactors/get_trailers.dart';
import 'package:core/src/model/movie.dart';
import 'package:core/src/model/trailer.dart';
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

  GetNowPlayingMovies _getNowPlayingMoviesInteractor;
  GetTrailers _getTrailersInteractor;

  MovieBloc(this._getNowPlayingMoviesInteractor, this._getTrailersInteractor) {
    _getMovies();
    _getTrailers();
  }

  void _getMovies() {
    _getNowPlayingMoviesInteractor.getNowPlayingMovies().listen(
          (movies) => moviesSink.add(movies),
          onError: (err) => error.add(err.toString()),
        );
  }

  void _getTrailers() {
    _movieId.listen(
        (id) => _getTrailersInteractor.getTrailers(id).listen(
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
