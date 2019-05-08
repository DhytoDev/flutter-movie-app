import 'package:core/src/domain/repositories/movie_repository.dart';
import 'package:core/src/model/trailer.dart';
import 'package:rxdart/rxdart.dart';

import 'use_case.dart';

class GetTrailers extends UseCase<MovieRepo, int> {
  BehaviorSubject<List<Trailer>> _trailers = BehaviorSubject();
  BehaviorSubject<String> _errorMessage = BehaviorSubject();

  Stream<List<Trailer>> get trailers => _trailers.stream;

  Stream<String> get errorMessage => _errorMessage.stream;

  GetTrailers(MovieRepo repository) : super(repository);

  Observable<List<Trailer>> getTrailers(int movieId) =>
      repository.getTrailersByMovieId(movieId);

  @override
  void execute({int params}) {
    repository.getTrailersByMovieId(params).listen(
        (trailers) => _trailers.sink.add(trailers),
        onError: (error) => _errorMessage.sink.add(error));
  }

  @override
  void dispose() {
    _trailers.close();
    _errorMessage.close();
  }
}
