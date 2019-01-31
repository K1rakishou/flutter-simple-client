
class BadHttpStatusCodeException implements Exception {
  final String cause;

  BadHttpStatusCodeException(this.cause);
}