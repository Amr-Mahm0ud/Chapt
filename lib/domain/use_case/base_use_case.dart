import 'package:chapt/data/network/errors/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> excute(In input);
}
