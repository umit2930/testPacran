class AppException implements Exception {

  final String? _message;
  final String? _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}


class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "");
}
class ForbiddenException extends AppException {
  ForbiddenException([message]) : super(message, "");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "InvalidInput ");
}

class ApiKeyNotFound extends AppException {
  ApiKeyNotFound([String? message]) : super(message, "Api key not found: ");
}

class UndefinedException extends AppException {
  UndefinedException([String? message]) : super(message, "Undefined exception: ");
}

class NoInternetException extends AppException {
  NoInternetException([String? message]) : super(message, "");
}
