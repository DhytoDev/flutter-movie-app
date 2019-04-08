import 'package:core/src/domain/repositories/movie_repository.dart';
import 'package:core/src/model/movie.dart';
import 'package:rxdart/rxdart.dart';

import 'use_case.dart';

class GetNowPlayingMovies extends UseCase<MovieRepo> {
  GetNowPlayingMovies(MovieRepo repository) : super(repository);

  Observable<List<Movie>> getNowPlayingMovies() =>
      repository.getNowPlayingMovies();
}
