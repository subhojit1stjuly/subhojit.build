/// A generic UseCase for asynchronous operations.
/// [T] is the return type of the use case.
/// [Params] represents the arguments required to execute the use case.
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

/// A generic UseCase for data streams.
/// [T] is the data type emitted by the stream.
abstract class StreamedUseCase<T> {
  Stream<T> get();
}

/// A generic UseCase for synchronous operations.
abstract class SyncUseCase<T, Params> {
  T call(Params params);
}

typedef NoParams = void;
