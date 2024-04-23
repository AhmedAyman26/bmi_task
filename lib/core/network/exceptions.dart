class OfflineException implements Exception {
  final int statusCode;
  final String errorMessage;

  OfflineException(this.statusCode, this.errorMessage);

  @override
  String toString() {
    return """
    ApiRequestException: 
      statusCode = $statusCode
      errorMessage = $errorMessage
    """
        .trim();
  }
}