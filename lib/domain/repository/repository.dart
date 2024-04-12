import 'package:chapt/data/network/api/requests.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/errors/failure.dart';

abstract class Repository {
  Future<Either<Failure, AuthenticationModel>> login(LoginRequest loginRequest);
  Future<Either<Failure, AuthenticationModel>> register(
      SignupRequest signupRequest);
  Future<Either<Failure, Message>> sendMessage(MessageRequest messageRequest);
}
