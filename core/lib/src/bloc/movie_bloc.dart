import 'package:core/core.dart';
import 'package:core/src/bloc/base_bloc.dart';
import 'package:core/src/domain/interactors/get_now_playing_movies.dart';

class MovieBloc extends BaseBloc {
  GetNowPlayingMovies _getNowPlayingMoviesUseCase;

  MovieBloc(this._getNowPlayingMoviesUseCase) {
    _getNowPlayingMoviesUseCase.execute();

    _getNowPlayingMoviesUseCase.error
        .listen((errorMessage) => error.add(errorMessage));
  }

  Stream<List<Movie>> getMovies() => _getNowPlayingMoviesUseCase.movies;

  Stream<String> errorMessage() => _getNowPlayingMoviesUseCase.error;

  @override
  void dispose() {
    super.dispose();
    _getNowPlayingMoviesUseCase.dispose();
  }
}
