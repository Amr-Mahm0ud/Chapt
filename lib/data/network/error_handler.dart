// ignore_for_file: constant_identifier_names

import 'package:chapt/data/network/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late final Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleError(error);
    } else {
      failure = ErrorType.DEFAULT.getFailure();
    }
  }

  Failure _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        ErrorType.CONNECTION_TIMEOUT.getFailure();
      case DioExceptionType.sendTimeout:
        ErrorType.SEND_TIMEOUT.getFailure();
      case DioExceptionType.receiveTimeout:
        ErrorType.RECIEVE_TIMEOUT.getFailure();
      case DioExceptionType.badCertificate:
        ErrorType.BAD_REQUEST.getFailure();
      case DioExceptionType.badResponse:
        if (error.response != null &&
            error.response!.statusCode != null &&
            error.response!.statusMessage != null) {
          return Failure(
              error.response!.statusCode!, error.response!.statusMessage!);
        } else {
          ErrorType.DEFAULT.getFailure();
        }
      case DioExceptionType.cancel:
        ErrorType.CANCEL.getFailure();
      case DioExceptionType.connectionError:
        ErrorType.DEFAULT.getFailure();
      case DioExceptionType.unknown:
        ErrorType.DEFAULT.getFailure();
    }
    return ErrorType.DEFAULT.getFailure();
  }
}

enum ErrorType {
  SUSCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECTION_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension ErrorTypeExtention on ErrorType {
  Failure getFailure() {
    switch (this) {
      case ErrorType.SUSCCESS:
        return Failure(ErrorCode.SUSCCESS, ErrorMwssage.SUSCCESS);
      case ErrorType.NO_CONTENT:
        return Failure(ErrorCode.NO_CONTENT, ErrorMwssage.NO_CONTENT);
      case ErrorType.BAD_REQUEST:
        return Failure(ErrorCode.BAD_REQUEST, ErrorMwssage.BAD_REQUEST);
      case ErrorType.FORBIDDEN:
        return Failure(ErrorCode.FORBIDDEN, ErrorMwssage.FORBIDDEN);
      case ErrorType.UNAUTHORIZED:
        return Failure(ErrorCode.UNAUTHORIZED, ErrorMwssage.UNAUTHORIZED);
      case ErrorType.NOT_FOUND:
        return Failure(ErrorCode.NOT_FOUND, ErrorMwssage.NOT_FOUND);
      case ErrorType.INTERNAL_SERVER_ERROR:
        return Failure(ErrorCode.INTERNAL_SERVER_ERROR,
            ErrorMwssage.INTERNAL_SERVER_ERROR);
      case ErrorType.CONNECTION_TIMEOUT:
        return Failure(
            ErrorCode.CONNECTION_TIMEOUT, ErrorMwssage.CONNECTION_TIMEOUT);
      case ErrorType.CANCEL:
        return Failure(ErrorCode.CANCEL, ErrorMwssage.CANCEL);
      case ErrorType.RECIEVE_TIMEOUT:
        return Failure(ErrorCode.RECIEVE_TIMEOUT, ErrorMwssage.RECIEVE_TIMEOUT);
      case ErrorType.SEND_TIMEOUT:
        return Failure(ErrorCode.SEND_TIMEOUT, ErrorMwssage.SEND_TIMEOUT);
      case ErrorType.CACHE_ERROR:
        return Failure(ErrorCode.CACHE_ERROR, ErrorMwssage.CACHE_ERROR);
      case ErrorType.NO_INTERNET_CONNECTION:
        return Failure(ErrorCode.NO_INTERNET_CONNECTION,
            ErrorMwssage.NO_INTERNET_CONNECTION);
      case ErrorType.DEFAULT:
        return Failure(ErrorCode.DEFAULT, ErrorMwssage.DEFAULT);
    }
  }
}

class ErrorCode {
  static const int SUSCCESS = 200;
  static const int NO_CONTENT = 201;
  static const int BAD_REQUEST = 400;
  static const int FORBIDDEN = 401;
  static const int UNAUTHORIZED = 403;
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_ERROR = 500;

  static const int CONNECTION_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ErrorMwssage {
  static const String SUSCCESS = 'Success';
  static const String NO_CONTENT = 'Success';
  static const String BAD_REQUEST = 'Bad request, Try again later';
  static const String FORBIDDEN = 'Forbidden request, Try again later';
  static const String UNAUTHORIZED = 'User is unautherized, Try again later';
  static const String NOT_FOUND = 'User not found';
  static const String INTERNAL_SERVER_ERROR =
      'Some thing went wrong, Try again later';

  static const String CONNECTION_TIMEOUT = 'Time out error, Try again later';
  static const String CANCEL = 'Request was cancelled, Try again later';
  static const String RECIEVE_TIMEOUT = 'Time out error, Try again later';
  static const String SEND_TIMEOUT = 'Time out error, Try again later';
  static const String CACHE_ERROR = 'Cache error, Try again later';
  static const String NO_INTERNET_CONNECTION =
      'Please check you internet connection';
  static const String DEFAULT = 'Some thing went wrong, Try again later';
}
