class ApiError {
  final int code;
  final String message;
  final String path;

  const ApiError({
    required this.code,
    required this.message,
    required this.path,
  });
}
