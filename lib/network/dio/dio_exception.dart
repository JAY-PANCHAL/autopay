import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
// import your StorageService if used
// import '../../services/storage_service.dart';

class DioExceptions implements Exception {
  late final String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.connectionError:
        if (dioError.message != null &&
            dioError.message!.contains("SocketException")) {
          message = "No Internet";
        } else {
          message = "Connection error occurred";
        }
        break;
      case DioExceptionType.unknown:
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        try {
          // StorageService().clearData();
          Get.offAllNamed(Routes.login);
        } catch (_) {}
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error is Map && error.containsKey('message')
            ? error['message']
            : 'Not found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
