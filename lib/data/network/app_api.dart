import 'package:chapt/app/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../response/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String? baseUrl}) = _AppServicesClient;

  @POST('/user/login')
  Future<AuthenticationResponses> login(
    @Field('email') String email,
    @Field('password') String password,
  );
}
