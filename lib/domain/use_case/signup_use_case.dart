import 'package:chapt/data/network/api/requests.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/errors/failure.dart';
import '../models/models.dart';
import '../repository/repository.dart';
import 'base_use_case.dart';

class SignupUseCase
    implements BaseUseCase<SignupUseCaseInput, AuthenticationModel> {
  final Repository _repositry;
  SignupUseCase(this._repositry);

  @override
  Future<Either<Failure, AuthenticationModel>> excute(
      SignupUseCaseInput input) async {
    return await _repositry.register(
        SignupRequest(input.email, input.pass, input.phoneNum, input.userName));
  }
}

class SignupUseCaseInput {
  String email;
  String pass;
  String phoneNum;
  String userName;
  SignupUseCaseInput(this.email, this.pass, this.phoneNum, this.userName);
}
