import 'package:chapt/app/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  //values of the header
  final String contenType = 'content-type';
  final String appJson = 'application/json';
  final String accept = 'accept';
  final String auth = 'authorization';
  final String lang = 'langauge';
  final String authVal = 'SEND TOKEN HERE';

  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      contenType: appJson,
      accept: appJson,
      auth: authVal,
      lang: AppConstants.appLang,
    };
    int timeOut = AppConstants.timeOut;

    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      headers: headers,
      sendTimeout: Duration(seconds: timeOut),
      receiveTimeout: Duration(seconds: timeOut),
    );

    // to log the request and response information
    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }
    return dio;
  }
}
