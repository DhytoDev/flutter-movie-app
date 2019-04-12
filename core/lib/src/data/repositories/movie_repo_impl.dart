import 'package:core/src/data/network/network_source.dart';
import 'package:core/src/domain/repositories/movie_repository.dart';
import 'package:core/src/model/movie.dart';
import 'package:core/src/model/trailer.dart';
import 'package:rxdart/rxdart.dart';

class MovieRepoImpl extends MovieRepo {
  @override
  Observable<List<Movie>> getNowPlayingMovies() {
    return Observable.fromFuture(MovieNetworkSource().getNowPlayingMovies())
        .map((movieResponse) => movieResponse.movies);
  }

  @override
  Observable<List<Trailer>> getTrailersByMovieId(int movieId) {
    return Observable.fromFuture(
            MovieNetworkSource().getTrailersByMovieId(movieId))
        .map((trailerResponse) => trailerResponse.trailers);
  }
}
