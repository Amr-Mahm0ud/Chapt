import 'dart:async';

import 'package:chapt/app/app_constants.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/domain/use_case/send_message_use_case.dart';
import 'package:chapt/presentation/common/freezed_data_classes.dart';
import 'package:chapt/presentation/view_models/base/base_view_model.dart';

import '../../common/popup_error.dart';

class MainViewModel extends BaseViewModel
    implements MainViewModelInputs, MainViewModelOutputs {
  final StreamController<String> _messageStreamController =
      StreamController<String>.broadcast();
  final StreamController<bool> _isLoadingStreamController =
      StreamController.broadcast();
  final StreamController<List<Message>> _allMessagesStreamController =
      StreamController.broadcast();

  final List<Message> _oldMessages = <Message>[];

  SendMessageObject _sendMessageObject =
      SendMessageObject(AppConstants.emptyStr, []);

  final SendMessageUseCase _sendMessageUseCase;
  MainViewModel(this._sendMessageUseCase);

  //base view model functions
  @override
  void dispose() {
    _messageStreamController.close();
    _isLoadingStreamController.close();
  }

  @override
  void start() {
    inputIsLoading.add(false);
  }

  //************************************************************* */
  //view model inputs functions
  @override
  Sink get inputIsLoading => _isLoadingStreamController.sink;

  @override
  Sink<String> get inputMessage => _messageStreamController.sink;

  @override
  Sink get inputAllMessages => _allMessagesStreamController.sink;

  @override
  sendMessage(context) async {
    try {
      inputIsLoading.add(true);
      _sendMessageObject = _sendMessageObject
          .copyWith(oldMsgs: [..._oldMessages.map((msg) => msg)]);
      _oldMessages.add(Message(_sendMessageObject.msg, 'user'));
      inputAllMessages.add([..._oldMessages.map((msg) => msg)]);

      (await _sendMessageUseCase.excute(
        SendMessageUseCaseInput(
            _sendMessageObject.msg, _sendMessageObject.oldMsgs),
      ))
          .fold((failure) async {
        inputIsLoading.add(false);
        _oldMessages.removeLast();
        PopupError.showErrorDialog(context, failure.message);
        return {};
      }, (data) async {
        inputIsLoading.add(false);
        _oldMessages.add(data);
        inputAllMessages.add([..._oldMessages.map((msg) => msg)]);
        _sendMessageObject = _sendMessageObject
            .copyWith(oldMsgs: [..._oldMessages.map((msg) => msg)]);
      });
    } catch (error) {
      PopupError.showErrorDialog(context, error.toString());
    }
  }

  @override
  setMessage(msg) {
    inputMessage.add(msg);
    _sendMessageObject = _sendMessageObject.copyWith(msg: msg);
  }

  //*************************************************************** */
  //output view model functions
  @override
  Stream<bool> get outputIsLoading => _isLoadingStreamController.stream;

  @override
  Stream<bool> get outputMessage =>
      _messageStreamController.stream.map((msg) => _validateMsg(msg));

  @override
  Stream<List<Message>> get outputAllMessages =>
      _allMessagesStreamController.stream;

  //validation functions
  bool _validateMsg(msg) {
    if (msg == null || msg.trim().isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

abstract class MainViewModelInputs extends BaseViewModelInputs {
  setMessage(value);
  sendMessage(context);
  Sink<String> get inputMessage;
  Sink get inputIsLoading;
  Sink get inputAllMessages;
}

abstract class MainViewModelOutputs extends BaseViewModelOutputs {
  Stream<bool> get outputMessage;
  Stream get outputIsLoading;
  Stream<List<Message>> get outputAllMessages;
}
