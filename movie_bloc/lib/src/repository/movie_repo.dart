import 'package:movie_bloc/src/data/network/tmdb_api.dart';
import 'package:movie_bloc/src/model/movie.dart';
import 'package:rxdart/rxdart.dart';

abstract class MovieRepo {
  Observable<List<Movie>> getMovies();
}

class MovieRepoImpl extends MovieRepo {
  @override
  Observable<List<Movie>> getMovies() {
    return Observable.fromFuture(TMDBApi().getMovies())
        .map((movieResponse) => movieResponse.movies);
  }
}
