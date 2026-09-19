/// Base exception for data-source failures.
class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

class DataParsingException extends AppException {
  const DataParsingException(super.message);
}

class LocalDataSourceException extends AppException {
  const LocalDataSourceException(super.message);
}
