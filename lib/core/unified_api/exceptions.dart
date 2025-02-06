// Exceptions are used to throw errors during code execution, which can be caught later for handling.
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
