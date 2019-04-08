import 'package:core/src/model/movie.dart';
import 'package:core/src/model/trailer.dart';
import 'package:rxdart/rxdart.dart';

abstract class MovieRepo {
  Observable<List<Movie>> getNowPlayingMovies();

  Observable<List<Trailer>> getTrailersByMovieId(int movieId);
}
