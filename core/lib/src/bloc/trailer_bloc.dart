import 'package:core/core.dart';
import 'package:rxdart/rxdart.dart';

class TrailerBloc extends BaseBloc {
  BehaviorSubject<int> _movieId = BehaviorSubject<int>();
  BehaviorSubject<List<Trailer>> _trailers = BehaviorSubject();

  Sink<int> get movieId => _movieId.sink;

  Sink<List<Trailer>> get trailersSink => _trailers.sink;

  Stream<List<Trailer>> get trailersStream => _trailers.stream;

  GetTrailers _getTrailersInteractor;

  TrailerBloc(this._getTrailersInteractor) {
    _getTrailers();
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
    super.dispose();
    _movieId.close();
    _trailers.close();
  }
}
