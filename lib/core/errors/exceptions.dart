class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class LocalException implements Exception {
  final String message;
  LocalException({required this.message});
}
