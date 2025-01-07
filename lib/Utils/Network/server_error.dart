import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  int _errorCode = 0;
  String _errorMessage = "";
  DioException _error = DioException(requestOptions: RequestOptions(path: ""));
  ServerError.withError({required DioException error}) {
    _error = error;
    _handleError(error);
  }

  getResponseCode() {
    return _error.response!.statusCode;
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(error) {
    _errorCode = error.response.statusCode;
    switch (error.type) {
      case DioExceptionType.cancel:
        _errorMessage = "Request was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        _errorMessage = "Connection timeout";
        break;
      case DioExceptionType.unknown:
        _errorMessage = "Connection failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioExceptionType.badResponse:
        _errorMessage = "Something went wrong";
        break;
      case DioExceptionType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        break;
    }

    // Check for 401 status code and extract the error message
    if (_errorCode == 401 && error.response != null) {
      Map<String, dynamic> errorResponse = error.response.data;
      if (errorResponse.containsKey("msg")) {
        _errorMessage = errorResponse["msg"];
      }
    }

    return _errorMessage;
  }
}
