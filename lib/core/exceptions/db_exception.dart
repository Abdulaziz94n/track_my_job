class DbException implements Exception {
  DbException({required this.message});

  final String message;

  @override
  String toString() => 'DbException(message: $message)';
}
