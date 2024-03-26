import 'package:chapt/data/network/errors/failure.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/domain/repository/repository.dart';
import 'package:chapt/domain/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/api/requests.dart';

class LoginUseCase implements BaseUseCase<LoginRequest, AuthenticationModel> {
  Repositry _repositry;
  LoginUseCase(this._repositry);

  @override
  Future<Either<Failure, AuthenticationModel>> excute(
      LoginRequest input) async {
    return await _repositry.login(input);
  }
}
