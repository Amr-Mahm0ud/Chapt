import 'package:chapt/data/network/api/app_api.dart';
import 'package:chapt/data/network/api/requests.dart';
import 'package:chapt/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponses> login(LoginRequest loginRequest);
  Future<AuthenticationResponses> register(SignupRequest signupRequest);
  Future<MessageResponse> sendMessage(MessageRequest messageRequest);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final AppServicesClient _appServicesClient;
  RemoteDataSourceImp(this._appServicesClient);

  @override
  Future<AuthenticationResponses> login(LoginRequest loginRequest) async {
    return await _appServicesClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<AuthenticationResponses> register(SignupRequest signupRequest) async {
    return await _appServicesClient.register(
      signupRequest.email,
      signupRequest.password,
      signupRequest.userName,
      signupRequest.phoneNumber,
    );
  }

  @override
  Future<MessageResponse> sendMessage(MessageRequest messageRequest) async {
    return await _appServicesClient.sendMessage(messageRequest);
  }
}
