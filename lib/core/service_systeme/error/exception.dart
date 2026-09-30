class ServerException implements Exception {}

class NetWorkException implements Exception {}

class NotFoundException implements Exception {}

class InternalException implements Exception {
  InternalException({
    this.message = 'Une erreur serveur est survenue',
    this.code = '',
  });
  final String message;
  final String code;

  @override
  String toString() => message;
}

class CacheException implements Exception {}

class LogoutException implements Exception {}

// Sub Exception
class InvalidFormatException implements Exception {}

class RangeErrorException implements Exception {}

class ArgumentErrorException implements Exception {}

class NoSuchMethodErrorException implements Exception {}

// core/errors/exceptions.dart

class ScanCancelledException implements Exception {
  const ScanCancelledException();
}
//InvalidScanFailure

class InvalidScanException implements Exception {
  const InvalidScanException();
}
