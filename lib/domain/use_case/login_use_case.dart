import 'package:chapt/data/network/errors/failure.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/domain/repository/repository.dart';
import 'package:chapt/domain/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/api/requests.dart';

class LoginUseCase
    implements BaseUseCase<LoginUseCaseInput, AuthenticationModel> {
  final Repository _repositry;
  LoginUseCase(this._repositry);

  @override
  Future<Either<Failure, AuthenticationModel>> excute(
      LoginUseCaseInput input) async {
    return await _repositry.login(LoginRequest(input.email, input.pass));
  }
}

class LoginUseCaseInput {
  String email;
  String pass;
  LoginUseCaseInput(this.email, this.pass);
}
