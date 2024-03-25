import 'package:chapt/data/network/app_api.dart';
import 'package:chapt/data/network/requests.dart';
import 'package:chapt/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponses> login(LoginRequest loginRequest);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final AppServicesClient _appServicesClient;
  RemoteDataSourceImp(this._appServicesClient);

  @override
  Future<AuthenticationResponses> login(LoginRequest loginRequest) async {
    return await _appServicesClient.login(
        loginRequest.email, loginRequest.password);
  }
}
