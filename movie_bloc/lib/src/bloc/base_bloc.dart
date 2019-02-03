import 'package:rxdart/rxdart.dart';

class BaseBloc {
  final BehaviorSubject<String> _error = BehaviorSubject(seedValue: "");

  Sink<String> get error => _error.sink;

  Stream<String> get errorStream => _error.stream;

  void dispose() {
    _error.close();
  }
}
