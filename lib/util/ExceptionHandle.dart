import 'package:dio/dio.dart';

String dioError(DioError error) => ZelException.fromDioError(error).message;

class ZelException implements Exception {
  ZelException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.CANCEL:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.DEFAULT:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.RESPONSE:
        message = handleError(dioError.response.statusCode);

        break;
      case DioErrorType.SEND_TIMEOUT:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message;

  String handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 405:
        return 'The requested resource was not found';
      case 500:
        return 'Internal server error';
      case 403:
        return 'Token expired';
      default:
        return 'Oops something went wrong';
    }
  }
}
