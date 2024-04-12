import 'package:chapt/app/app_constants.dart';
import 'package:chapt/data/data_source/remote_data_source.dart';
import 'package:chapt/data/mappers/mappers.dart';
import 'package:chapt/data/network/errors/error_handler.dart';
import 'package:chapt/data/network/errors/failure.dart';
import 'package:chapt/data/network/network_state.dart';
import 'package:chapt/data/network/api/requests.dart';
import 'package:chapt/data/response/responses.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImp implements Repository {
  final NetworkState _networkStateImp;
  final RemoteDataSource _remoteDataSourceImp;
  RepositoryImp(this._networkStateImp, this._remoteDataSourceImp);

  @override
  Future<Either<Failure, AuthenticationModel>> login(
      LoginRequest loginRequest) async {
    if (await _networkStateImp.isConnected) {
      // user's deviece is connected
      // so we complete the login request

      try {
        final response = await _remoteDataSourceImp.login(loginRequest);

        // In mockApi we made the success response code equal 0
        if (response.status == AppConstants.zero) {
          // successful request
          return Right(response.toDomain());
        } else {
          // error from api
          return Left(ErrorType.DEFAULT.getFailure());
        }
      } catch (exception) {
        return Left(ErrorHandler.handle(exception).failure);
      }
    } else {
      // network error
      return Left(ErrorType.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationModel>> register(
      SignupRequest signupRequest) async {
    if (await _networkStateImp.isConnected) {
      // user's deviece is connected
      // so we complete the login request
      try {
        final response = await _remoteDataSourceImp.register(signupRequest);

        // In mockApi we made the success response code equal 0
        if (response.status == AppConstants.zero) {
          // successful request
          return Right(response.toDomain());
        } else {
          // error from api
          return Left(ErrorType.DEFAULT.getFailure());
        }
      } catch (exception) {
        return Left(ErrorHandler.handle(exception).failure);
      }
    } else {
      // network error
      return Left(ErrorType.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(
      MessageRequest messageRequest) async {
    if (await _networkStateImp.isConnected) {
      // user's deviece is connected
      // so we complete the login request

      try {
        final MessageResponse response =
            await _remoteDataSourceImp.sendMessage(messageRequest);

        // In mockApi we made the success response code equal 0
        if (response.message != null) {
          // successful request
          return Right(response.toDomain());
        } else {
          // error from api
          return Left(ErrorType.DEFAULT.getFailure());
        }
      } catch (exception) {
        return Left(ErrorType.DEFAULT.getFailure());
      }
    } else {
      // network error
      return Left(ErrorType.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
