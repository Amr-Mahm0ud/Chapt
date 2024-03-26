import 'package:chapt/data/network/api/requests.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/errors/failure.dart';

abstract class Repositry {
  Future<Either<Failure, AuthenticationModel>> login(LoginRequest loginRequest);
}
