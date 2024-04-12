import 'package:chapt/data/network/errors/failure.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/domain/repository/repository.dart';
import 'package:chapt/domain/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';

import '../../data/network/api/requests.dart';

class SendMessageUseCase
    implements BaseUseCase<SendMessageUseCaseInput, Message> {
  final Repository _repositry;
  SendMessageUseCase(this._repositry);

  @override
  Future<Either<Failure, Message>> excute(SendMessageUseCaseInput input) async {
    return await _repositry
        .sendMessage(MessageRequest(input.message, input.oldMessages));
  }
}

class SendMessageUseCaseInput {
  String message;
  List<Message> oldMessages;
  SendMessageUseCaseInput(this.message, this.oldMessages);
}
