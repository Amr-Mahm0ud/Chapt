import 'dart:async';

import 'package:chapt/app/app_constants.dart';
import 'package:chapt/domain/models/models.dart';
import 'package:chapt/domain/use_case/send_message_use_case.dart';
import 'package:chapt/presentation/common/freezed_data_classes.dart';
import 'package:chapt/presentation/view_models/base/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../common/popup_error.dart';

class MainViewModel extends BaseViewModel
    implements MainViewModelInputs, MainViewModelOutputs {
  final StreamController<String> _messageStreamController =
      StreamController<String>.broadcast();

  final StreamController<List<Message>> _allMessagesStreamController =
      StreamController.broadcast();

  final List<Message> _oldMessages = <Message>[];

  bool isLoading = false;

  SendMessageObject _sendMessageObject =
      SendMessageObject(AppConstants.emptyStr, []);

  final SendMessageUseCase _sendMessageUseCase;
  MainViewModel(this._sendMessageUseCase);

  //base view model functions
  @override
  void dispose() {
    _messageStreamController.close();
  }

  @override
  void start() {
  }

  clearChat() {
    _oldMessages.clear();
    inputAllMessages.add(<Message>[]);
  }

  // format response Message
  TextSpan formatText(String text, context) {
    RegExp regex = RegExp(r'\*\*(.*?)\*\*');
    //to add every splited text
    List<TextSpan> spans = [];

    //decide if it a title or regular text
    text.splitMapJoin(
      regex,
      onMatch: (Match match) {
        spans.add(
          TextSpan(
            text: match.group(1),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        );
        return '';
      },
      onNonMatch: (String text) {
        spans.add(
          TextSpan(
            text: text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
        return '';
      },
    );
    return TextSpan(children: spans);
  }

  //************************************************************* */
  //view model inputs functions

  @override
  Sink<String> get inputMessage => _messageStreamController.sink;

  @override
  Sink get inputAllMessages => _allMessagesStreamController.sink;

  @override
  sendMessage(context) async {
    try {
      isLoading = true;
      _sendMessageObject = _sendMessageObject
          .copyWith(oldMsgs: [..._oldMessages.map((msg) => msg)]);
      _oldMessages.add(Message(_sendMessageObject.msg, 'user'));
      inputAllMessages.add([..._oldMessages.map((msg) => msg)]);

      (await _sendMessageUseCase.excute(
        SendMessageUseCaseInput(
            _sendMessageObject.msg, _sendMessageObject.oldMsgs),
      ))
          .fold((failure) async {
        isLoading = false;
        _oldMessages.removeLast();
        PopupError.showErrorDialog(context, failure.message);
        return {};
      }, (data) async {
        isLoading = false;
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
  Sink get inputAllMessages;
}

abstract class MainViewModelOutputs extends BaseViewModelOutputs {
  Stream<bool> get outputMessage;
  Stream<List<Message>> get outputAllMessages;
}
