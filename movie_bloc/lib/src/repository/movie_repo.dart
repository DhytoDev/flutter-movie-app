import 'package:movie_bloc/src/data/network/tmdb_api.dart';
import 'package:movie_bloc/src/model/movie.dart';
import 'package:movie_bloc/src/model/trailer.dart';
import 'package:rxdart/rxdart.dart';

abstract class MovieRepo {
  Observable<List<Movie>> getMovies();

  Observable<List<Trailer>> getTrailersByMovieId(int movieId);
}

class MovieRepoImpl extends MovieRepo {
  @override
  Observable<List<Movie>> getMovies() {
    return Observable.fromFuture(TMDBApi().getMovies())
        .map((movieResponse) => movieResponse.movies);
  }

  @override
  Observable<List<Trailer>> getTrailersByMovieId(int movieId) {
    return Observable.fromFuture(TMDBApi().getTrailersByMovieId(movieId))
        .map((trailers) => trailers);
  }
}
