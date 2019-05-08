abstract class UseCase<R, T> {
  R _repository;

  UseCase(this._repository);

  R get repository => _repository;

  void execute({T params});

  void dispose();
}
