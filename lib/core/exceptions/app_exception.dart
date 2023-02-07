class AppException implements Exception {
  AppException({required this.message});
  final String message;

  @override
  String toString() => 'AppException(message: $message)';
}

// this file need to be rechecked