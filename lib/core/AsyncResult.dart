
class AsyncResult<R> {
  R result;
  Exception error;

  static AsyncResult<R> success<R>(R result) {
    return AsyncResult(result, null);
  }

  static AsyncResult<R> fail<R>(Exception error) {
    return AsyncResult(null, error);
  }

  AsyncResult(this.result, this.error);

  bool isSuccess() => result != null;
  bool isError() => error != null;

  R getResult() => result;
  Exception getError() => error;
}