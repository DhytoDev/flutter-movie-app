import 'package:core/src/domain/repositories/movie_repository.dart';
import 'package:core/src/model/trailer.dart';
import 'package:rxdart/rxdart.dart';

import 'use_case.dart';

class GetTrailers extends UseCase<MovieRepo> {
  GetTrailers(MovieRepo repository) : super(repository);

  Observable<List<Trailer>> getTrailers(int movieId) =>
      repository.getTrailersByMovieId(movieId);
}
