class AuthenticationException implements Exception {
  late String _message;

  AuthenticationException(String message) {
    _message = message.replaceAll('Exception: ', '');
  }

  String get message => _message;
}
