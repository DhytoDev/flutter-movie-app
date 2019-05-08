import 'package:core/core.dart';
import 'package:core/src/domain/interactors/get_trailers.dart';
import 'package:rxdart/rxdart.dart';

class TrailerBloc extends BaseBloc {
  BehaviorSubject<int> _movieId = BehaviorSubject<int>();

  Sink<int> get movieId => _movieId.sink;

  final GetTrailers _getTrailersUseCase;

  TrailerBloc(this._getTrailersUseCase) {
    _movieId.stream
        .listen((movieId) => _getTrailersUseCase.execute(params: movieId));

    _getTrailersUseCase.errorMessage
        .listen((errorMessage) => error.add(errorMessage));
  }

  Stream<List<Trailer>> getTrailers() => _getTrailersUseCase.trailers;

  Stream<String> errorMessage() => _getTrailersUseCase.errorMessage;

  @override
  void dispose() {
    super.dispose();
    _movieId.close();
    _getTrailersUseCase.dispose();
  }
}
