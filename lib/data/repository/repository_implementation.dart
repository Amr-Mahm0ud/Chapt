import 'package:chapt/data/data_source/remote_data_source.dart';
import 'package:chapt/data/mappers/mappers.dart';
import 'package:chapt/data/network/failure.dart';
import 'package:chapt/data/network/network_state.dart';
import 'package:chapt/data/network/requests.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImp implements Repositry {
  final NetworkStateImp _networkStateImp;
  final RemoteDataSourceImp _remoteDataSourceImp;
  RepositoryImp(this._networkStateImp, this._remoteDataSourceImp);

  @override
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequest loginRequest) async {
    if (await _networkStateImp.isConnected) {
      // user's deviece is connected
      // so we complete the login request

      final response = await _remoteDataSourceImp.login(loginRequest);

      // In mockApi we made the success response code equal 0
      if (response.status == 0) {
        // successful request

        return Right(response.toDomain());
      } else {
        // error from api
        // TODO: implement failure here
        return Left(Failure(409, response.message ?? 'Bussiness error'));
      }
    } else {
      // network error
      // TODO: implement network failure
      return Left(Failure(501, 'Check your internet connection'));
    }
  }
}
