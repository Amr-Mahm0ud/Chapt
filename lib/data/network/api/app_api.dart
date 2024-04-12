import 'package:chapt/app/api_key.dart';
import 'package:chapt/app/app_constants.dart';
import 'package:chapt/data/network/api/requests.dart';
import 'package:dio/dio.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../response/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServicesClient {
  factory AppServicesClient(Dio dio, {String? baseUrl}) = _AppServicesClient;

  @POST('/user/login')
  Future<AuthenticationResponses> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST('/user/signup')
  Future<AuthenticationResponses> register(
    @Field('email') String email,
    @Field('password') String password,
    @Field('user_name') String userName,
    @Field('phone_number') String phoneNumber,
  );

  Future<MessageResponse> sendMessage(MessageRequest messageRequest);
}
