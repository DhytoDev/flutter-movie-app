abstract class UseCase<R> {
  R _repository;

  UseCase(this._repository);

  R get repository => _repository;
}
