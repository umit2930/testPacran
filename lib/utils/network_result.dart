class NetworkResult<T> {
  T? data;
  String? message;

  NetworkStatus status;

  NetworkResult.loading() : status = NetworkStatus.loading;

  NetworkResult.success({required this.data}) : status = NetworkStatus.success;

  NetworkResult.error({required this.message}) : status = NetworkStatus.error;
}

enum NetworkStatus {
  loading,
  error,
  success,
}
